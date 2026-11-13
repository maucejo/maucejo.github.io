# maucejo.github.io — Calepin source

Personal academic website built with [Calepin](https://vincentarelbundock.github.io/calepin/)
and a custom theme (`themes/aucejo`, extending the bundled `academic` theme).

## Commands

```sh
calepin watch . _site --serve --open      # live preview
calepin compile .                         # build into _site/
python3 scripts/update_publications.py    # refresh data/publications.json from HAL
python3 scripts/update_software.py        # refresh data/software.json (versions, GitHub stars)
```

## Layout

| Path | Role |
|---|---|
| `calepin.toml` | Site config: menus, social links, `[store]` values used by the theme (name, role, tagline…) |
| `*.typ` | Pages (title + description come from `#metadata((...)) <website-metadata>`) |
| `_lib/ui.typ` | Typst components emitting HTML: `section`, `card(s)`, `chips`, `timeline`, `stats`, `button`, `pub-list`… |
| `data/publications.json` | Publication list generated from HAL |
| `data/software.json` | Package versions and GitHub stars, generated from the links in `software.typ` |
| `themes/aucejo/layouts/` | `site.html` (inner pages), `site-home.html` (landing page with hero) |
| `themes/aucejo/partials/` | Overridden nav, brand, footer, head (fonts) + new `page-header`, `social-links` |
| `themes/aucejo/css/60_aucejo.css` | Design tokens (`--calepin-*`, light/dark) and `mx-*` components |
| `themes/aucejo/js/aucejo.js` | Publication search/filter, scroll reveal |
