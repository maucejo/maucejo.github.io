---
title: 'Bayesian structural source identification using generalized Gaussian priors'

# Authors
# If you created a profile for a user (e.g. the default `admin` user), write the username (folder name) here
# and it will be replaced with their full name and linked to their profile.
authors:
  - Olivier De Smet
  - admin

# Author notes (optional)
author_notes:
  - 'Equal contribution'
  - 'Equal contribution'

date: '2013-09-01T00:00:00Z'
doi: 'https://hal.archives-ouvertes.fr/hal-02068565'

# Schedule page publish date (NOT publication's date).
publishDate: '2013-09-01T00:00:00Z'

# Publication type.
# Legend: 0 = Uncategorized; 1 = Conference paper; 2 = Journal article;
# 3 = Preprint / Working Paper; 4 = Report; 5 = Book; 6 = Book section;
# 7 = Thesis; 8 = Patent
publication_types: ['1']

# Publication name and optional abbreviated publication name.
publication: In *11th International Conference on Vibration Problems*
publication_short: In *ICVP 2013*

abstract: <p style="text-align:justify">The reconstruction of mechanical sources from vibration measurements is known to be an ill-posed inverse problem. One of the most widespread method to overcome this difficulty is the Tikhonov regularization. Such an approach consists in including in the formulation of the inverse problem some prior information on the nature of the sources to constrain the space of solutions. However, the reconstructed sources are generally too smooth to properly deal with localized sources. This paper aims at providing an identification methodology able to take advantage of prior information on the nature of excitation sources. More particularly, we will focus on the identification of localized sources. For this purpose, the Bayesian framework is well adapted, since it offers a rigorous probabilistic approach to exploit our a priori knowledge on the nature of the sources to identify. The proposed Bayesian formulation is based on the use of generalized gaussian priors, which provide a flexible way to introduce a priori information. Usually one use standard gaussian priors for both uncertainties and source distributions. Because noise and sources are usually of different kind (e.g. white noise on measurement and sparsity of sources distribution), we propose to introduce two different priors. The first one tuned to deal with uncertainties and the second one adapted to the nature of the sources exciting the structure. Practically, the inverse problem is solved from a Generalized Iteratively Reweighted Least-Squares algorithm. The proposed methodology is illustrated on various numerical and experimental examples (i.e. for different sources distribution). It is shown that using priors depending on sources distribution nature are needed to improve drastically the quality of the source identification.</p>

# Summary. An optional shortened abstract.
summary: <p style="text-align:justify">The reconstruction of mechanical sources from vibration measurements is known to be an ill-posed inverse problem. One of the most widespread method to overcome this difficulty is the Tikhonov regularization. Such an approach consists in including in the formulation of the inverse problem some prior information on the nature of the sources to constrain the space of solutions...</p>

tags:
    - Inverse problems
    - Regularization
    - Additive regularization
    - Bayesian framework

# Display this page in the Featured widget?
featured: false

# Custom links (uncomment lines below)
# links:
# - name: Custom Link
#   url: http://example.org

url_pdf: 'https://hal.archives-ouvertes.fr/hal-02068565/document'
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