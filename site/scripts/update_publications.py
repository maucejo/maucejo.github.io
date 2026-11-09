#!/usr/bin/env python3
"""Fetch publications from HAL and write them to data/publications.json.

Citation counts are added from OpenAlex for publications that have a DOI.

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
USER_AGENT = "calepin-site-builder"
OPENALEX_BATCH = 50
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


def fetch_json(url: str):
    request = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    with urllib.request.urlopen(request, timeout=30) as response:
        return json.load(response)


def fetch_citations(dois: list[str]) -> dict[str, tuple[int, str]]:
    """Return {doi: (cited_by_count, openalex_url)} for the given DOIs."""
    found: dict[str, tuple[int, str]] = {}
    for start in range(0, len(dois), OPENALEX_BATCH):
        batch = dois[start : start + OPENALEX_BATCH]
        query = urllib.parse.urlencode(
            {
                "filter": "doi:" + "|".join(batch),
                "select": "id,doi,cited_by_count",
                "per-page": OPENALEX_BATCH,
            }
        )
        try:
            results = fetch_json(f"https://api.openalex.org/works?{query}")["results"]
        except Exception as exc:  # network or API error: keep going without citations
            print(f"Warning: OpenAlex request failed ({exc})")
            continue
        for work in results:
            doi = (work.get("doi") or "").lower().removeprefix("https://doi.org/")
            if doi:
                found[doi] = (int(work.get("cited_by_count") or 0), work.get("id", ""))
    return found


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
    docs = fetch_json(f"https://api.archives-ouvertes.fr/search/?{query}")["response"]["docs"]

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

    dois = sorted({e["doi"].strip().lower() for e in entries if e["doi"]})
    citations = fetch_citations(dois)
    for entry in entries:
        count, openalex = citations.get(entry["doi"].strip().lower(), (None, ""))
        entry["citations"] = count
        entry["openalex"] = openalex

    entries.sort(key=lambda e: (-int(e["year"] or 0), e["title"].lower()))
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT.write_text(json.dumps(entries, ensure_ascii=False, indent=1) + "\n", encoding="utf-8")
    print(f"Wrote {len(entries)} publications to {OUTPUT}")
    print(f"Citation counts found for {len(citations)}/{len(dois)} DOIs (OpenAlex)")


if __name__ == "__main__":
    main()
