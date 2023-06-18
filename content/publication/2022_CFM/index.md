---
title: 'Une nouvelle méthode d’identification de force basée sur une vision bayésienne unifiée du filtrage de type Kalman'

# Authors
# If you created a profile for a user (e.g. the default `admin` user), write the username (folder name) here
# and it will be replaced with their full name and linked to their profile.
authors:
  - Julian Ghibaudo
  - admin
  - Olivier De Smet

# Author notes (optional)
author_notes:
  - 'Equal contribution'
  - 'Equal contribution'
  - 'Equal contribution'

date: '2022-08-29T00:00:00Z'
doi: ''

# Schedule page publish date (NOT publication's date).
publishDate: '2022-08-29T00:00:00Z'

# Publication type.
# Legend: 0 = Uncategorized; 1 = Conference paper; 2 = Journal article;
# 3 = Preprint / Working Paper; 4 = Report; 5 = Book; 6 = Book section;
# 7 = Thesis; 8 = Patent
publication_types: ['1']

# Publication name and optional abbreviated publication name.
publication: In *25ème Congrès Français de Mécanique*
publication_short: In *CFM 2022*

abstract: <p style="text-align:justify">Ce papier présente un nouveau filtre bayésien pour l'estimation des sources d'excitation mécanique dans le domaine temporel à partir d'un ensemble de mesures de vibrations. Le filtre proposé est dérivé d'une formulation bayésienne générale, unifiant la plupart des filtres récursifs développés au cours de la dernière décennie pour résoudre les problèmes d'estimation de l'état et de l'entrée. Plus précisément, le filtre bayésien proposé permet de promouvoir la parcimonie spatiale du vecteur d'entrée estimé, en supposant que le vecteur d'entrée prédit est un vecteur aléatoire dont les composantes sont indépendantes, identiquement distribuées et suivent une loi normale généralisée. Pour estimer correctement les paramètres de cette dernière, une optimisation bayésienne est mise en place à chaque pas de temps. La validité de l'approche proposée, appelée Sparse adaptive Bayesian filter (SaBF), est évaluée numériquement. En particulier, les comparaisons effectuées avec certains filtres de l'état de l'art montrent que la stratégie proposée surpasse les filtres existants en termes de précision d'estimation de l'entrée et évite le phénomène dit de dérive ("drift").</p>

# Summary. An optional shortened abstract.
summary: <p style="text-align:justify">Ce papier présente un nouveau filtre bayésien pour l'estimation des sources d'excitation mécanique dans le domaine temporel à partir d'un ensemble de mesures de vibrations. Le filtre proposé est dérivé d'une formulation bayésienne générale, unifiant la plupart des filtres récursifs développés au cours de la dernière décennie pour résoudre les problèmes d'estimation de l'état et de l'entrée...</p>

tags:
    - Inverse Problems
    - Regularization
    - Kalman Filter

# Display this page in the Featured widget?
featured: false

# Custom links (uncomment lines below)
# links:
# - name: Custom Link
#   url: http://example.org

url_pdf: ''
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