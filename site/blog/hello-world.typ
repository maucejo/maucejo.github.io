#import "/_lib/ui.typ": *

// ---------------------------------------------------------------------------
// To publish a post:
//  1. Copy this file to blog/<slug>.typ and edit `meta` below.
//  2. Run `calepin compile .` — the post shows up on the Blog page, on the
//     home page, in the prev/next links and in the Atom feed automatically.
//
// `type` (one per post) is shown on the blog card; `tags` are shown in the
// post. `author` defaults to the site owner and `cover` is optional.
// `toc: true` adds a table of contents beside the post, listing the `==`
// headings (`toc: (depth: 4)` also lists `===` ones); leave it out for short posts.
// `draft: true` keeps the post out of the listings and the feed while you
// write it; its page is still built, so you can preview it by its URL.
// Put cover images in assets/images/blog/ (1200×630, kept light: they are
// embedded in the pages that show them).
// ---------------------------------------------------------------------------
#let meta = (
  title: "Hello, world: how posts work on this blog",
  description: "A sample post showing how to write and publish a new entry.",
  date: "2026-11-12",
  author: "Mathieu Aucejo",
  type: "Tutorial",
  tags: ("Blog", "Typst", "Calepin"),
  cover: "/assets/images/blog/hello-world.svg",
  cover-alt: "A damped oscillation",
  toc: true,
)

#metadata(post-meta(meta)) <website-metadata>

#post-header(meta)

#lead[
  This is a sample post. It shows how a blog entry is written and how it
  connects to the listing on the Blog page.
]

== Writing content

A post is a regular Typst page: headings, paragraphs, lists, figures and
equations all work as elsewhere on the site.

$ m accent(x, dot.double) + c accent(x, dot) + k x = f(t) $

== Code

```text
omega_n = sqrt(k / m)
```

#post-footer(meta)
