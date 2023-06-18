---
title: 'Vibration mitigation through analogous piezoelectric coupling'

# Authors
# If you created a profile for a user (e.g. the default `admin` user), write the username (folder name) here
# and it will be replaced with their full name and linked to their profile.
authors:
  - Boris Lossouarn
  - admin
  - Jean-François Deü
  - Kenneth A. Cunefare
  - Gaëtn Kerschen

# Author notes (optional)
author_notes:
  - 'Equal contribution'
  - 'Equal contribution'
  - 'Equal contribution'
  - 'Equal contribution'
  - 'Equal contribution'

date: '2019-06-01T00:00:00Z'
doi: 'https://hal.archives-ouvertes.fr/hal-03196461'

# Schedule page publish date (NOT publication's date).
publishDate: '2019-06-01T00:00:00Z'

# Publication type.
# Legend: 0 = Uncategorized; 1 = Conference paper; 2 = Journal article;
# 3 = Preprint / Working Paper; 4 = Report; 5 = Book; 6 = Book section;
# 7 = Thesis; 8 = Patent
publication_types: ['1']

# Publication name and optional abbreviated publication name.
publication: In *Joint MEMOCS Workshop on Models of Complex Materials and Systems*
publication_short: In *Joint MEMOCS Workshop on Models of Complex Materials and Systems*

abstract: <p style="text-align:justify">Vibration mitigation solutions involving piezoelectric components as sensors and actuators are relatively widespread in the active control community. Yet, structural vibrations can also be reduced by employing piezoelectric material as passive electromechanical transducers able to convert the vibration energy into electrical energy. This strategy is directly related to the concept of piezoelectric shunts, which consists in connecting a one-port electrical element to a transducer for impedance matching and energy dissipation. Using passive components such as resistors, inductors or capacitors leads to fully passive and inherently stable control solutions. Actually, adding an inductor in the circuit creates an electrical resonance due to the charge exchanges with the piezoelectric capacitance. In this case, impedance matching consists in tuning the resonance of the shunt to the natural frequency of the mechanical structure. The equivalent of a tuned mass damper is thus implemented with a controller offering similar dynamics as the structure to be controlled. This definitely shows the interest of electrical analogues when considering piezoelectric coupling. Analogous coupling can be extended to vibration mitigation of multiple mechanical modes of a continuous structure. In this case, the passive controller still needs to represent an electrical analogue. A multi-resonant electrical network is thus required to approximate the modal properties of the mechanical structure. An adequate electrical topology is obtained by discretizing the constitutive equations of the continuous medium and then applying an electromechanical analogy. Just like the first “analogue computers”, the obtained networks show inductors, capacitors and transformers, whose numbers and values are chosen according to the frequency band of interest. Interconnecting an array of piezoelectric patches with those passive components creates an electromechanical waveguide whose boundary conditions need to satisfy the electromechanical analogy. This passive control strategy is applied to the damping of one-dimensional structures such as bars and beams. The design of two-dimensional analogous networks then allows an extension to vibration mitigation of thin plates. Both numerical and experimental results validate the concept of analogous piezoelectric coupling, which offers interesting perspectives concerning its application to more complex structures.</p>

# Summary. An optional shortened abstract.
summary: <p style="text-align:justify">Vibration mitigation solutions involving piezoelectric components as sensors and actuators are relatively widespread in the active control community. Yet, structural vibrations can also be reduced by employing piezoelectric material as passive electromechanical transducers able to convert the vibration energy into electrical energy...</p>

tags:
    - Vibration control
    - Piezoelectric coupling

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