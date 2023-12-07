---
title: 'Performances of a family of new sequential Bayesian filters for input estimation'

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

date: '2023-09-18T00:00:00Z'
doi: 'https://doi.org/10.1016/j.ymssp.2023.110794'

# Schedule page publish date (NOT publication's date).
publishDate: '2023-12-07T00:00:00Z'

# Publication type.
# Legend: 0 = Uncategorized; 1 = Conference paper; 2 = Journal article;
# 3 = Preprint / Working Paper; 4 = Report; 5 = Book; 6 = Book section;
# 7 = Thesis; 8 = Patent
publication_types: ['2']

# Publication name and optional abbreviated publication name.
publication: In *Mechanical Systems and Signal Processing*
publication_short: In *MSSP*

abstract: <p style="text-align:justify">During their lifetime, structures are usually subjected to some mechanical shocks that generate high levels of vibration that can damage the structure itself as well as the embedded devices. However, the characteristics of these shocks (location, time history, maximum intensity, etc.) are often unknown due to the inaccessibility of the excitation region for direct force measurements or the inability to instrument the system. Therefore, inverse methods have been developed to quantify these complex excitations. Recently, a Bayesian formulation of the input-state estimation problem for linear systems has been proposed by the authors, which unifies most of the state-of-the-art filters. In this paper, we present two novel Bayesian filters derived from this framework - (a) the Correlated Dual Kalman Filter (CDKF), which is one of the filters that naturally follows from the unified Bayesian formulation, and (b) the Component Bayesian Filter (CBF), which promotes spatial sparsity of the input vector. Essentially, these filters differ in the prior distributions used to convey information about the spatial distribution of the input vector to be identified. The performance of these filters is evaluated through a numerical experiment and a real-world application aimed at reconstructing a sparse and transient excitation acting on a linear structure. A comparison of these original filters with other Bayesian filters proposed in the literature is also proposed. In particular, the numerical experiment allows to study the performance of the proposed filters in different scenarios, such as the number of sensors, the measurement noise level or the sensor configuration, while the real-world application allows to test them in operational conditions. More specifically, it is shown that filters promoting the spatial sparsity of the input vector, such as CBF, lead to a consistent identified excitation profile when acceleration measurements are the only available data.</p>

# Summary. An optional shortened abstract.
summary: <p style="text-align:justify">During their lifetime, structures are usually subjected to some mechanical shocks that generate high levels of vibration that can damage the structure itself as well as the embedded devices. However, the characteristics of these shocks (location, time history, maximum intensity, etc.) are often unknown due to the inaccessibility of the excitation region for direct force measurements or the inability to instrument the system...</p>

tags:
    - Inverse Problems
    - Regularization
    - Kalman Filtering
    - Bayesian framework

# Display this page in the Featured widget?
featured: true

# Custom links (uncomment lines below)
# links:
# - name: Custom Link
#   url: http://example.org

url_pdf: 'https://hal.science/hal-04221352'
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