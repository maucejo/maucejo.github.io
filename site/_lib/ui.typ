// UI components for the aucejo theme.
//
// Each helper emits plain HTML elements with `mx-*` classes, styled by
// themes/aucejo/css/60_aucejo.css. Import them in a page with
//   #import "/_lib/ui.typ": *

#let el(tag, class: none, attrs: (:), body) = {
  let a = attrs
  if class != none { a.insert("class", class) }
  html.elem(tag, attrs: a, body)
}

#let link-out(href, body, class: none) = {
  let a = (href: href)
  if href.starts-with("http") {
    a.insert("target", "_blank")
    a.insert("rel", "noopener")
  }
  el("a", class: class, attrs: a, body)
}

/// A page section with a small uppercase kicker above an h2 title.
#let section(title, kicker: none, id: none, body) = {
  let attrs = if id != none { (id: id) } else { (:) }
  el("section", class: "mx-section", attrs: attrs, {
    el("header", class: "mx-section-head", {
      if kicker != none { el("p", class: "mx-kicker", kicker) }
      el("h2", class: "mx-section-title", title)
    })
    body
  })
}

/// Lead paragraph, slightly larger than body text.
#let lead(body) = el("p", class: "mx-lead", body)

/// Pill-shaped tags.
#let chips(..items) = el("ul", class: "mx-chips",
  items.pos().map(i => el("li", class: "mx-chip", i)).join())

/// Responsive grid of cards. `cols` is the max number of columns.
#let cards(cols: 3, ..items) = el("div", class: "mx-cards",
  attrs: (style: "--mx-cols: " + str(cols)), items.pos().join())

/// One card. When `href` is given, the whole card is a link.
#let card(title, href: none, tag: none, icon: none, meta: none, body) = {
  let inner = {
    if icon != none or tag != none {
      el("div", class: "mx-card-top", {
        if icon != none { el("span", class: "mx-card-icon", icon) }
        if tag != none { el("span", class: "mx-card-tag", tag) }
      })
    }
    el("h3", class: "mx-card-title", title)
    el("div", class: "mx-card-body", body)
    if meta != none { el("p", class: "mx-card-meta", meta) }
    if href != none { el("span", class: "mx-card-arrow", attrs: ("aria-hidden": "true"), "→") }
  }
  if href != none {
    link-out(href, class: "mx-card is-link", inner)
  } else {
    el("article", class: "mx-card", inner)
  }
}

/// Vertical timeline. Items: (when: "2019", what: [...], where: [...])
#let timeline(..items) = el("ol", class: "mx-timeline", items.pos().map(it =>
  el("li", class: "mx-timeline-item", {
    el("span", class: "mx-timeline-when", it.when)
    el("div", class: "mx-timeline-body", {
      el("p", class: "mx-timeline-what", it.what)
      if it.at("where", default: none) != none {
        el("p", class: "mx-timeline-where", it.at("where"))
      }
    })
  })
).join())

/// Row of key figures. Items: (value: "84", label: "publications")
#let stats(..items) = el("dl", class: "mx-stats", items.pos().map(it =>
  el("div", class: "mx-stat", {
    el("dt", class: "mx-stat-label", it.label)
    el("dd", class: "mx-stat-value", it.value)
  })
).join())

/// Inline image (e.g. a language logo) sized to the text.
#let logo(src, alt) = html.elem("img", attrs: (class: "mx-inline-logo", src: src, alt: alt))

/// Call-to-action button.
#let button(href, body, ghost: false) = link-out(href,
  class: if ghost { "mx-btn mx-btn-ghost" } else { "mx-btn mx-btn-primary" }, body)

// ---------------------------------------------------------------------------
// Publications (data/publications.json, generated from HAL)
// ---------------------------------------------------------------------------

#let publications = json("/data/publications.json")

#let category-labels = (
  article: "Journal article",
  conference: "Conference",
  chapter: "Book chapter",
  thesis: "Thesis",
)

#let category-plurals = (
  article: "Journal articles",
  conference: "Conferences",
  chapter: "Book chapters",
  thesis: "Theses",
)

#let _is-me(name) = name in ("Mathieu Aucejo", "M. Aucejo", "Aucejo Mathieu")

#let _authors(names) = names.enumerate().map(((i, n)) => {
  let sep = if i == 0 { "" } else if i == names.len() - 1 { " and " } else { ", " }
  sep
  if _is-me(n) { el("strong", class: "mx-me", n) } else { n }
}).join()

/// One publication entry.
#let pub(p) = el("li", class: "mx-pub", attrs: (
  "data-category": p.category,
  "data-year": str(p.year),
  "data-search": lower(p.title + " " + p.authors.join(" ") + " " + p.venue),
), {
  el("div", class: "mx-pub-side", {
    el("span", class: "mx-pub-year", str(p.year))
  })
  el("div", class: "mx-pub-main", {
    el("span", class: "mx-pub-type is-" + p.category, category-labels.at(p.category))
    el("p", class: "mx-pub-title", {
      let href = if p.doi != "" { "https://doi.org/" + p.doi } else { p.hal }
      link-out(href, p.title)
    })
    el("p", class: "mx-pub-authors", _authors(p.authors))
    if p.venue != "" { el("p", class: "mx-pub-venue", p.venue) }
    el("p", class: "mx-pub-links", {
      if p.doi != "" { link-out("https://doi.org/" + p.doi, class: "mx-pub-link", "DOI") }
      if p.hal != "" { link-out(p.hal, class: "mx-pub-link", "HAL") }
      if p.pdf != "" { link-out(p.pdf, class: "mx-pub-link is-pdf", "PDF") }
    })
  })
})

/// List of publications, optionally filtered by category and truncated.
#let pub-list(category: none, limit: none) = {
  let items = publications.filter(p => category == none or p.category == category)
  if limit != none { items = items.slice(0, calc.min(limit, items.len())) }
  el("ol", class: "mx-pubs", items.map(pub).join())
}

/// Search box + category filter, wired up by themes/aucejo/js/publications.js.
#let pub-filters() = {
  let counts = (:)
  for p in publications {
    counts.insert(p.category, counts.at(p.category, default: 0) + 1)
  }
  el("div", class: "mx-pub-filters", attrs: ("data-mx-pub-filters": ""), {
    html.elem("input", attrs: (
      type: "search",
      class: "mx-pub-search",
      placeholder: "Search titles, co-authors, venues…",
      "aria-label": "Search publications",
    ))
    el("div", class: "mx-pub-tabs", attrs: (role: "toolbar", "aria-label": "Filter by type"), {
      html.elem("button", attrs: (type: "button", class: "mx-tab is-active", "data-filter": "all"),
        "All " + html.elem("span", attrs: (class: "mx-tab-count"), str(publications.len())))
      for (key, label) in category-plurals.pairs() {
        if key in counts {
          html.elem("button", attrs: (type: "button", class: "mx-tab", "data-filter": key),
            label + " " + html.elem("span", attrs: (class: "mx-tab-count"), str(counts.at(key))))
        }
      }
    })
    el("p", class: "mx-pub-empty", attrs: (hidden: "hidden"), "No publication matches your search.")
  })
}
