#import "/_lib/ui.typ": *

#metadata((
  title: "Research",
  description: "Identifying, modeling and controlling vibrations and sound in mechanical structures.",
)) <website-metadata>

#lead[
  My research takes place at the #link-out("https://www.macs.cnam.fr/")[MACS] laboratory of #link-out("https://www.cnam.fr/")[Le Cnam]. It lies at the crossroads of structural dynamics, acoustics and signal processing, with a strong focus on methods that can be used on real measured data.
]

#section(kicker: "Theme 1", id: "inverse-problems", [Inverse problems])[
  How can we recover the forces acting on a structure from a limited number of noisy vibration measurements? I work on Bayesian methods — Bayesian inference, Bayesian regularization filtering and Gaussian processes — in time and frequency domains for source identification in
  structural dynamics.

  #chips[Source identification][Bayesian inference][Bayesian filtering][Regularization][Gaussian processes]
]

#section(kicker: "Theme 2", id: "vibration-control", [Vibration control])[
  Reducing vibration levels and radiated noise in mechanical systems, by
  designing passive treatments and active control strategies.

  #chips[Active control][Passive damping][Structural dynamics]
]

#section(kicker: "Theme 3", id: "vibro-acoustics", [Vibro-acoustic modeling])[
  Building models that predict how structures vibrate and radiate sound, and how they interact with surrounding fluids. This is the basis for both identification and control.

  #chips[Vibro-acoustics][Modal analysis][Numerical methods]
]

#section(kicker: "Tools", [Open science])[
  Most of the methods I develop are released as open-source software, so that results can be reproduced and reused in teaching.

  #cards(cols: 2,
    card([Publications], href: "publications.html", tag: "HAL")[
      The complete list of my articles and conference papers, most with
      open-access PDFs.
    ],
    card([Software], href: "software.html", tag: "GitHub")[
      Julia packages for structural dynamics and Typst templates for
      scientific writing.
    ],
  )
]
