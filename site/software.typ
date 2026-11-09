#import "/_lib/ui.typ": *

#metadata((
  title: "Software",
  description: "Open-source packages for structural dynamics in Julia and templates for scientific writing in Typst.",
)) <website-metadata>

#section(kicker: "Julia", [Structural dynamics])[
  #cards(cols: 2,
    card([StructuralVibration.jl], href: "https://github.com/maucejo/StructuralVibration.jl",
      icon: logo("assets/images/julia.svg", "Julia"), tag: "Julia")[
      Generate vibration data for mechanical systems. Useful in teaching to illustrate vibration theory, and in research to test new methods on synthetic data.
    ],
    card([UFFFiles.jl], href: "https://github.com/maucejo/UFFFiles.jl",
      icon: logo("assets/images/julia.svg", "Julia"), tag: "Julia")[
      Read and write Universal File Format (UFF) files, commonly used to
      exchange experimental vibration data.
    ],
  )
]

#section(kicker: "Typst", [Scientific writing])[
  #cards(cols: 2,
    card([bookly], href: "https://github.com/maucejo/bookly",
      icon: logo("assets/images/typst_logo.png", "Typst"), tag: "Typst")[
      A template for writing academic documents and books.
    ],
    card([slydekit], href: "https://github.com/maucejo/slydekit",
      icon: logo("assets/images/typst_logo.png", "Typst"), tag: "Typst")[
      A presentation framework with a theme system, incremental reveals and citation handling, built on Typst's native state and queries.
    ],
    card([elsearticle], href: "https://github.com/maucejo/elsearticle",
      icon: logo("assets/images/typst_logo.png", "Typst"), tag: "Typst")[
      Mimics Elsevier's `elsarticle.cls` LaTeX class to format manuscriptscfor submission.
    ],
    card([elspub], href: "https://github.com/maucejo/elspub",
      icon: logo("assets/images/typst_logo.png", "Typst"), tag: "Typst")[
      Reproduces the look of published Elsevier articles. This is a proof of concept for Typst in scientific publishing.
    ],
  )
]

#el("p", class: "mx-note")[
  Everything else lives on #link-out("https://github.com/maucejo")[GitHub].
]
