---
title: Modélisation de l'interaction structure-fluide lourd par l'approche PTF (Patch Transfer Functions)

# Authors
# If you created a profile for a user (e.g. the default `admin` user), write the username (folder name) here
# and it will be replaced with their full name and linked to their profile.
authors:
  - Laurent Maxit
  - admin
  - Nicolas Totaro
  - Jean-Louis Guyader

# Author notes (optional)
author_notes:
  - 'Equal contribution'
  - 'Equal contribution'
  - 'Equal contribution'
  - 'Equal contribution'

date: '2010-04-01T00:00:00Z'
doi: 'https://hal.archives-ouvertes.fr/hal-00538357'

# Schedule page publish date (NOT publication's date).
publishDate: '2010-04-01T00:00:00Z'

# Publication type.
# Legend: 0 = Uncategorized; 1 = Conference paper; 2 = Journal article;
# 3 = Preprint / Working Paper; 4 = Report; 5 = Book; 6 = Book section;
# 7 = Thesis; 8 = Patent
publication_types: ['1']

# Publication name and optional abbreviated publication name.
publication: In *10ème Congrès Français d'Acoustique*
publication_short: In *CFA 2010*

abstract: <p style="text-align:justify">On s'intéresse dans cet article à la modélisation du couplage entre une structure et une cavité d'eau pour des fréquences situées en dessous de la fréquence critique de la structure. Ce type de problème se caractérise par le fait que (a), le couplage entre la structure et le fluide est fort; (b) le rayonnement de la structure fait apparaître des ondes évanescentes qu'il est difficile de reproduire à partir de séries modales. Ce problème a été traité dans de nombreuses publications et peut être résolu à partir de méthodes numériques telles que les éléments finis, les éléments finis de frontière, les éléments infinis, etc. Les temps calculs deviennent cependant très vite prohibitifs dès que la fréquence augmente. Pour les réduire, on propose de sous-structurer le problème vibro-acoustique à partir de l'approche PTF (Patch Transfert Functions). Celle-ci consiste à décomposer le système en différents sous-domaines et à découper les surfaces de couplage en pavés Des fonctions de transfert par pavés caractérisent alors les sous-domaines. Celles-ci peuvent être calculées par différentes méthodes sur les sous-domaines découplés. Elles servent ensuite à reconstituer la réponse du système global à partir des équations de continuité, qui ne font pas intervenir d'hypothèse sur la nature du couplage entre les sous-systèmes. Il est donc possible de sous-structurer le problème de différentes façons. Nous allons ainsi étudier différentes sous-structurations du problème ainsi que différentes techniques de calcul des fonctions de transfert par pavé, ceci dans le but de minimiser les temps de calcul.</p>

# Summary. An optional shortened abstract.
summary: <p style="text-align:justify">On s'intéresse dans cet article à la modélisation du couplage entre une structure et une cavité d'eau pour des fréquences situées en dessous de la fréquence critique de la structure. Ce type de problème se caractérise par le fait que (a), le couplage entre la structure et le fluide est fort; (b) le rayonnement de la structure fait apparaître des ondes évanescentes qu'il est difficile de reproduire à partir de séries modales...</p>

tags:
    - Vibro-acoustic modeling
    - Substructuring
    - Finite element method

# Display this page in the Featured widget?
featured: false

# Custom links (uncomment lines below)
# links:
# - name: Custom Link
#   url: http://example.org

url_pdf: 'https://hal.archives-ouvertes.fr/hal-00538357/document'
url_code: ''
url_dataset: ''
url_poster: ''
url_project: ''
url_slides: ''
url_source: ''
url_video: ''

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
image:
  caption:
  focal_point: ''
  preview_only: false

# Associated Projects (optional).
#   Associate this publication with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `internal-project` references `content/project/internal-project/index.md`.
#   Otherwise, set `projects: []`.
projects:
  - []

# Slides (optional).
#   Associate this publication with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides: "example"` references `content/slides/example/index.md`.
#   Otherwise, set `slides: ""`.
slides: []
---