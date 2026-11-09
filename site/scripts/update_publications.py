#!/usr/bin/env python3
"""Fetch publications from HAL and write them to data/publications.json.

Usage (from the `site/` directory):

    python3 scripts/update_publications.py

The Typst pages (index.typ, publications.typ) read the generated JSON file,
so re-run this script whenever new work is deposited on HAL, then rebuild.
"""

from __future__ import annotations

import json
import urllib.parse
import urllib.request
from pathlib import Path

HAL_ID = "mathieu-aucejo"
OUTPUT = Path(__file__).resolve().parent.parent / "data" / "publications.json"

FIELDS = [
    "halId_s",
    "uri_s",
    "docType_s",
    "title_s",
    "authFullName_s",
    "producedDateY_i",
    "journalTitle_s",
    "conferenceTitle_s",
    "bookTitle_s",
    "city_s",
    "country_s",
    "volume_s",
    "issue_s",
    "page_s",
    "doiId_s",
    "fileMain_s",
]

# HAL document types -> categories displayed on the site.
CATEGORIES = {
    "ART": "article",
    "COMM": "conference",
    "POSTER": "conference",
    "COUV": "chapter",
    "OUV": "chapter",
    "THESE": "thesis",
    "HDR": "thesis",
}


def first(value):
    if isinstance(value, list):
        return value[0] if value else ""
    return value or ""


def venue(doc: dict) -> str:
    kind = doc.get("docType_s")
    if kind == "ART":
        parts = [doc.get("journalTitle_s", "")]
        if doc.get("volume_s"):
            parts.append(f"vol. {doc['volume_s']}")
        if doc.get("page_s"):
            parts.append(f"p. {doc['page_s']}")
        return ", ".join(p for p in parts if p)
    if kind in ("COMM", "POSTER"):
        parts = [doc.get("conferenceTitle_s", ""), doc.get("city_s", "")]
        return ", ".join(p for p in parts if p)
    if kind in ("COUV", "OUV"):
        return doc.get("bookTitle_s", "")
    if kind == "THESE":
        return "PhD thesis"
    if kind == "HDR":
        return "Habilitation thesis (HDR)"
    return ""


def main() -> None:
    query = urllib.parse.urlencode(
        {
            "q": f"authIdHal_s:{HAL_ID}",
            "fl": ",".join(FIELDS),
            "rows": 1000,
            "sort": "producedDateY_i desc",
            "wt": "json",
        }
    )
    url = f"https://api.archives-ouvertes.fr/search/?{query}"
    request = urllib.request.Request(url, headers={"User-Agent": "calepin-site-builder"})
    with urllib.request.urlopen(request, timeout=30) as response:
        docs = json.load(response)["response"]["docs"]

    entries = []
    for doc in docs:
        category = CATEGORIES.get(doc.get("docType_s"))
        if category is None:
            continue
        entries.append(
            {
                "id": doc.get("halId_s", ""),
                "category": category,
                "type": doc.get("docType_s", ""),
                "title": first(doc.get("title_s")).strip().rstrip("."),
                "authors": doc.get("authFullName_s", []),
                "year": doc.get("producedDateY_i", 0),
                "venue": venue(doc),
                "doi": doc.get("doiId_s", ""),
                "hal": doc.get("uri_s", ""),
                "pdf": doc.get("fileMain_s", ""),
            }
        )

    entries.sort(key=lambda e: (-int(e["year"] or 0), e["title"].lower()))
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT.write_text(json.dumps(entries, ensure_ascii=False, indent=1) + "\n", encoding="utf-8")
    print(f"Wrote {len(entries)} publications to {OUTPUT}")


if __name__ == "__main__":
    main()
