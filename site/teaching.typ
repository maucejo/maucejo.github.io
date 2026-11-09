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
  #cards(
    cols: 2,
    card([Structural vibrations], tag: "Engineering school")[
      This course covers the fundamentals of vibrations in mechanical systems, including free and forced vibrations, damping, and resonance. Students will learn to analyze and model vibrating systems using both analytical and numerical methods. This course deals with the theory of vibrations, modal analysis, and the use of software tools for vibration analysis.
    ],
    card([Rigid body dynamics], tag: "Engineering school")[
      This course introduces the principles of rigid body dynamics, including kinematics, kinetics, and the equations of motion for rigid bodies. Students will learn to analyze the motion of rigid bodies in two and three dimensions, and apply these concepts to real-world engineering problems. This course includes numerical simulations and exercises to reinforce the theoretical concepts.
    ],
    card([Manufacturing processes], tag: "Engineering school")[
      This course covers the fundamentals of machining processes, including machining kinematics, CNC programming using G-code, and CAM software for generating machining operations and process plans. Students will also study machining variability, tolerances, and the calculation of manufacturing dimensions. Practical exercises and lab sessions provide hands-on experience in applying these concepts.
    ],
    card([Introduction to research activities], tag: "Engineering school")[
      This course introduces students to the fundamentals of research, including the research process, data collection and analysis, and the communication of results. Students will learn how to design and conduct research projects, as well as how to evaluate and interpret research findings.
    ],
  )
]

#section(kicker: "Courses", [Past courses])[
  #cards(
    cols: 2,
    card([Vibrations], tag: "Master")[
      This course covers the fundamentals of vibrations in mechanical systems, including free and forced vibrations, damping, and resonance. Students will learn to analyze and model vibrating systems using both analytical and numerical methods. This course deals with the theory of vibrations, modal analysis, and the use of software tools for vibration analysis.
    ],
    card([Structural dynamics], tag: "Engineering school")[
      This course introduces the principles of structural dynamics, including the analysis of dynamic systems, modal analysis, and the response of structures to dynamic loads. Students will learn to model and analyze the dynamic behavior of structures using both analytical and numerical methods.
    ],
    card([Vibro-acoustics], tag: "Master")[
      This course covers the fundamentals of vibro-acoustics, including the interaction between vibrating structures and the surrounding fluid medium. Students will learn to analyze and model the acoustic radiation from vibrating structures, as well as the propagation of sound in different media.
    ],
  )
]

#section(kicker: "Resources", [Teaching tools])[
  #card([StructuralVibration.jl], href: "https://github.com/maucejo/StructuralVibration.jl", tag: "Julia")[
    A Julia package I use to illustrate vibration theory and its numerical
    implementation in class.
  ]
]
