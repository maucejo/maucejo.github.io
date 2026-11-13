#!/usr/bin/env python3
"""Fetch the version and GitHub star count of each package listed on the
Software page, and write them to data/software.json.

Usage (from the `site/` directory):

    python3 scripts/update_software.py

The packages are the GitHub repositories linked from software.typ
(`href: "https://github.com/<owner>/<repo>"`), so there is no list to maintain
here. The version comes from the first source that has one:

  1. Typst Universe (packages.typst.org), for Typst packages;
  2. the latest GitHub release;
  3. the most recent Git tag;
  4. `version:` in a Quarto extension's _extensions/*/_extension.yml.

Set GITHUB_TOKEN to raise the GitHub API rate limit (60 requests/hour
without it, which is enough for a handful of packages).
"""

from __future__ import annotations

import json
import os
import re
import sys
import urllib.error
import urllib.request
from datetime import datetime, timezone
from pathlib import Path

USER_AGENT = "calepin-site-builder"
SITE = Path(__file__).resolve().parent.parent
SOURCE = SITE / "software.typ"
OUTPUT = SITE / "data" / "software.json"
TYPST_INDEX = "https://packages.typst.org/preview/index.json"


def fetch(url: str, github: bool = False):
    headers = {"User-Agent": USER_AGENT}
    if github:
        headers["Accept"] = "application/vnd.github+json"
        token = os.environ.get("GITHUB_TOKEN")
        if token:
            headers["Authorization"] = f"Bearer {token}"
    request = urllib.request.Request(url, headers=headers)
    with urllib.request.urlopen(request, timeout=30) as response:
        return response.read().decode("utf-8")


def fetch_json(url: str, github: bool = False):
    try:
        return json.loads(fetch(url, github))
    except urllib.error.HTTPError as error:
        if error.code == 404:
            return None
        raise


def version_key(version: str):
    return tuple(int(part) if part.isdigit() else 0 for part in re.split(r"[.+-]", version))


def clean(version: str) -> str:
    return version[1:] if version[:1] in "vV" else version


def typst_versions() -> dict[str, str]:
    """Latest published version of every Typst Universe package."""
    latest: dict[str, str] = {}
    for package in fetch_json(TYPST_INDEX) or []:
        name, version = package["name"], package["version"]
        if name not in latest or version_key(version) > version_key(latest[name]):
            latest[name] = version
    return latest


def quarto_version(repo: str) -> str | None:
    tree = fetch_json(f"https://api.github.com/repos/{repo}/git/trees/HEAD?recursive=1", github=True)
    for entry in (tree or {}).get("tree", []):
        path = entry["path"]
        if path.startswith("_extensions/") and path.endswith("_extension.yml"):
            text = fetch(f"https://raw.githubusercontent.com/{repo}/HEAD/{path}")
            match = re.search(r"^version:\s*['\"]?([^'\"\s]+)", text, re.MULTILINE)
            if match:
                return match.group(1)
    return None


def package_info(repo: str, universe: dict[str, str]) -> dict:
    data = fetch_json(f"https://api.github.com/repos/{repo}", github=True)
    if data is None:
        raise RuntimeError(f"repository {repo} not found")
    name = repo.split("/", 1)[1]
    info = {"stars": data["stargazers_count"], "version": None, "version_source": None}

    if name in universe:
        info.update(version=universe[name], version_source="Typst Universe")
        return info
    release = fetch_json(f"https://api.github.com/repos/{repo}/releases/latest", github=True)
    if release and release.get("tag_name"):
        info.update(version=clean(release["tag_name"]), version_source="GitHub release")
        return info
    tags = fetch_json(f"https://api.github.com/repos/{repo}/tags?per_page=1", github=True)
    if tags:
        info.update(version=clean(tags[0]["name"]), version_source="Git tag")
        return info
    version = quarto_version(repo)
    if version:
        info.update(version=clean(version), version_source="Quarto extension")
    return info


def main() -> int:
    repos = list(dict.fromkeys(re.findall(r'https://github\.com/([\w.-]+/[\w.-]+)"', SOURCE.read_text())))
    if not repos:
        print("No GitHub repository found in software.typ", file=sys.stderr)
        return 1

    previous = json.loads(OUTPUT.read_text()).get("packages", {}) if OUTPUT.exists() else {}
    universe = typst_versions()
    packages = {}
    failed = 0
    for repo in repos:
        try:
            packages[repo] = package_info(repo, universe)
        except Exception as error:  # keep the last known values on failure
            failed += 1
            print(f"  {repo}: {error}", file=sys.stderr)
            if repo in previous:
                packages[repo] = previous[repo]
            continue
        info = packages[repo]
        print(f"  {repo}: v{info['version']} ({info['version_source']}), {info['stars']} stars")

    OUTPUT.write_text(json.dumps({
        "updated": datetime.now(timezone.utc).strftime("%Y-%m-%d"),
        "packages": packages,
    }, indent=2, ensure_ascii=False) + "\n")
    print(f"Wrote {len(packages)} packages to {OUTPUT.relative_to(SITE)}")
    return 1 if failed == len(repos) else 0


if __name__ == "__main__":
    sys.exit(main())
