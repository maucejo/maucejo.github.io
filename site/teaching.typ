#import "/_lib/ui.typ": *

#metadata((
  title: "Teaching",
  description: "Courses in structural mechanics, vibrations and acoustics at Le Cnam.",
)) <website-metadata>

// TODO: replace the placeholder courses below with your actual courses.

#lead[
  I teach structural mechanics, vibrations and acoustics at
  #link-out("https://www.cnam.fr/")[Le Cnam], to engineering students and
  professionals in continuing education.
]

#section(kicker: "Courses", [Current courses])[
  #cards(cols: 2,
    card([Course title], tag: "Master")[
      Short description of the course: objectives, content, format.
    ],
    card([Course title], tag: "Engineering school")[
      Short description of the course: objectives, content, format.
    ],
  )
]

#section(kicker: "Resources", [Teaching tools])[
  #card([StructuralVibration.jl], href: "https://github.com/maucejo/StructuralVibration.jl", tag: "Julia")[
    A Julia package I use to illustrate vibration theory and its numerical
    implementation in class.
  ]
]
