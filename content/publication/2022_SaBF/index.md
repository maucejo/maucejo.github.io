---
title: 'A Sparse adaptive Bayesian filter for input estimation problems'

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

date: '2022-06-20T00:00:00Z'
doi: 'https://dx.doi.org/10.1016/j.ymssp.2022.109416'

# Schedule page publish date (NOT publication's date).
publishDate: '2022-06-20T00:00:00Z'

# Publication type.
# Legend: 0 = Uncategorized; 1 = Conference paper; 2 = Journal article;
# 3 = Preprint / Working Paper; 4 = Report; 5 = Book; 6 = Book section;
# 7 = Thesis; 8 = Patent
publication_types: ['2']

# Publication name and optional abbreviated publication name.
publication: In *Mechanical Systems and Signal Processing*
publication_short: In *MSSP*

abstract: <p style="text-align:justify">The present paper introduces a novel Bayesian filter for estimating mechanical excitation sources in the time domain from a set of vibration measurements. The proposed filter is derived from a very general Bayesian formulation, unifying most of the state-of-the-art recursive filters developed in the last decade for solving input-state estimation problems. More specifically, the proposed Bayesian filter allows promoting the spatial sparsity of the estimated input vector, by assuming that the predicted input vector is a random vector with independent and identically distributed components following a generalized Gaussian distribution. To properly estimate the most probable parameters of the latter probability distribution, a nested Bayesian optimization is implemented. The validity of the proposed approach, called Sparse adaptive Bayesian Filter, is assessed both numerically and experimentally. In particular, the comparisons performed with some state-of-the-art filters show that the proposed strategy outperforms the existing filters in terms of input estimation accuracy and avoids the so-called drift effect.</p>

# Summary. An optional shortened abstract.
summary: <p style="text-align:justify">The present paper introduces a novel Bayesian filter for estimating mechanical excitation sources in the time domain from a set of vibration measurements. The proposed filter is derived from a very general Bayesian formulation, unifying most of the state-of-the-art recursive filters developed in the last decade for solving input-state estimation problems...</p>

tags:
    - Inverse Problems
    - Regularization
    - Kalman Filtering
    - Bayesian framework

# Display this page in the Featured widget?
featured: false

# Custom links (uncomment lines below)
# links:
# - name: Custom Link
#   url: http://example.org

url_pdf: 'https://hal.archives-ouvertes.fr/hal-03700301/document'
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