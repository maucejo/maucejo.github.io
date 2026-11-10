#import "/_lib/ui.typ": *

#metadata((
  title: "Home",
  layout: "layouts/site-home.html",
)) <website-metadata>

#let n-articles = publications.filter(p => p.category == "article").len()
#let n-conf = publications.filter(p => p.category == "conference").len()

#stats(
  (value: str(n-articles), label: "Journal articles"),
  (value: str(n-conf), label: "Conference papers"),
  (value: "15+", label: "Years in research"),
  (value: "7", label: "Open-source packages"),
)

#section(kicker: "About", [Welcome!])[
  #lead[
    I am a full professor of Structural Mechanics and Acoustics at the
    Laboratoire de Mécanique, Acoustique, Contrôle et Calcul Scientifique
    (#link-out("https://www.macs.cnam.fr/")[MACS]) of
    #link-out("https://www.cnam.fr/")[Le Cnam] in Paris.
  ]

  I am an enthusiastic and avid user of the
  Typst #logo("assets/images/typst_logo.png", "Typst") markup language and the
  Julia #logo("assets/images/julia.svg", "Julia") programming language. I
  turn a good part of my research and teaching material into open-source tools.
]

#section(kicker: "Research", [Research interests])[
  #cards(cols: 3,
    card([Inverse problems], tag: "Identification", href: "research.html#inverse-problems")[
      Estimating unknown excitation sources from vibration
      measurements with Bayesian methods.
    ],
    card([Vibration control], tag: "Control", href: "research.html#vibration-control")[
      Reducing structural vibrations and noise through passive and active
      strategies.
    ],
    card([Vibro-acoustic modeling], tag: "Modelling", href: "research.html#vibro-acoustics")[
      Predicting how structures vibrate and radiate sound, from analytical
      models to numerical simulation.
    ],
  )
]

#section(kicker: "Publications", [Recent work])[
  #pub-list(category: "article", limit: 4)
  #button("publications.html")[All publications #sym.arrow]
]

#section(kicker: "Background", [Education])[
  #timeline(
    (when: "2019", what: [Habilitation to supervise research (HDR)], where: [Conservatoire national des arts et métiers, France]),
    (when: "2010", what: [PhD in Acoustics], where: [INSA Lyon, France]),
    (when: "2007", what: [MSc in Acoustics], where: [INSA Lyon, France]),
    (when: "2007", what: [MEng in Mechanical Engineering], where: [INSA Lyon, France]),
  )
]

#section(kicker: "Contact", [Let's talk])[
  #el("div", class: "mx-contact", {
    el("p", [Interested in a collaboration, a PhD or internship position, or one
      of my software packages? Feel free to reach out.])
    button("mailto:mathieu.aucejo@lecnam.net")[mathieu.aucejo\@lecnam.net]
  })
]
