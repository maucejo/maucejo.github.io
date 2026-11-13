#import "/_lib/ui.typ": *

#let meta = (
  title: "Make beautiful apps with Makie",
  description: "Develop interactive apps to share your ideas",
  date: "2026-11-13",
  author: "Mathieu Aucejo",
  type: "Tutorial",
  tags: ("Blog", "Julia", "Makie.jl"),
  cover: "assets/cover.svg",
  cover-alt: "Damped oscillations of a spring–mass system next to a panel of four sliders",
  toc: (depth: 4),
)

#metadata(post-meta(meta)) <website-metadata>

#show: math-html

#post-header(meta)

#lead[
  In this tutorial, I show how to build interactive apps with #link("https://docs.makie.org/stable/")[Makie.jl]. The workflow is illustrated on a classic example from mechanical vibrations: the free response of a damped spring–mass oscillator. By the end, you will have a small app in which the mass, stiffness, damping and initial conditions are tuned with sliders, while the displacement updates in real time.
]

== Introduction

For years, Matlab and Python were my everyday tools for research and teaching. For my vibration courses, I used #link("https://dash.plotly.com/")[Plotly Dash] to build small web apps illustrating key concepts, such as the free response of undamped and damped spring–mass oscillators. Students could play with the parameters and immediately see their effect, which is often more convincing than a long derivation on the blackboard.

Then I decided to switch to Julia. Like every newcomer, I had to rethink my workflow: find the right packages, learn to "think the Julian way", and get used to the compilation latency. Not everything is perfect, but I enjoy writing Julia code, and the community is remarkably welcoming to beginners. Porting my Dash apps to Julia was therefore a natural exercise, and Makie.jl quickly appeared as the right tool for the job: it is a fast, expressive plotting ecosystem with built-in widgets (sliders, buttons, menus…) and a reactive system to wire them to the plots.

This post walks through that process. It does not try to cover all of Makie, only what you need to go from a static figure to a responsive app.

== Vibration model

Before writing any code, let us recall the physics. A mass $m$ is attached to a spring of stiffness $k$ and a viscous damper of coefficient $c$. Without external forcing, its displacement $x(t)$  the following ordinary differential equation $dot(x)$:

$
cases(
dot.double(x)(t) + 2 xi omega_0 dot(x)(t) + omega_0^2 x(t) = 0,
x(0) = x_0,
dot(x)(0) = v_0
),
$
where $omega_0 = sqrt(k/m)$ is the natural frequency and $xi$ is the damping ratio. The initial conditions are the displacement $x_0$ and velocity $v_0$ at time $t = 0$.

Depending on the value of the damping ratio $xi$ and $omega_0 > 0$, the system can have 4 different types of free response:

- an undamped motion when $xi = 0$. In this case, the free response is:
$
x(t) = x_0 cos omega_0 t + v_0/omega_0 sin omega_0 t.
$

- an underdamped motion when $0 < xi < 1$. In this case, the free response is:
$
x(t) = [x_0 cos Omega_0 t + (v_0 + xi Omega_0 x_0)/Omega_0 sin Omega_0 t]e^(-xi omega_0 t),
$
where $Omega_0 = omega_0 sqrt(1 - xi^2)$.

- a critically damped motion when $\xi = 1$. In this case, the free response is:
$
x(t) = [x_0 + (v_0 + omega_0 x_0)t]e^(-omega_0 t).
$

- an overdamped motion when $\xi > 1$. In this case, the free response is:
$
x(t) = [x_0 cosh \beta t + (v_0 + xi omega_0 x_0)/beta sinh beta t]e^(-xi omega_0 t),
$
where $beta = omega_0 sqrt(xi^2 - 1)$.

Finally, if $omega = 0$, the mass is free from constraints and the free response is:
$
x(t) = x_0 + v_0 t.
$

These closed-form expressions are all we need: the app only has to evaluate them on a time grid each time a parameter changes.

In what follows, I will use #link("https://maucejo.github.io/StructuralVibration.jl/")[StructuralVibration.jl] to compute the displacement, but you can implement your own function if you prefer.

== First steps

When I discover a new framework, I go straight to its documentation. For Makie, everything starts on the #link("https://docs.makie.org/stable/")[Makie.jl documentation website], which offers tutorials, a reference of all plot types and blocks, and many examples.

#figure(
  image("assets/makie_doc.png", width: 75%, alt: "Home page of the Makie.jl documentation website"),
  caption: "Makie.jl documentation website",
)

=== Choosing a backend

Makie itself only describes figures; rendering is delegated to a _backend_. Three of them are available:

- *GLMakie*: GPU-accelerated rendering in a native window. It is the most complete backend for interactivity and the one used in this tutorial.
- *WGLMakie*: WebGL rendering in the browser or in a notebook, useful to share an app on the web.
- *CairoMakie*: high-quality static vector graphics (PDF, SVG), perfect for publications but not interactive.

Since the code is the same for all backends, you can develop an app with GLMakie and later switch to WGLMakie to put it online.

=== Installation

From the Julia REPL, install GLMakie in your project environment:

```julia
#| eval: false
using Pkg
Pkg.add("GLMakie")
```

The first `using GLMakie` takes a while, as the package is precompiled. Subsequent loadings are much faster.

=== A first static plot

Let us start by plotting the response of the oscillator for a fixed set of parameters. We first write a function returning the displacement on a time grid:

```julia
#| eval: false
using GLMakie

# Model definition
m  = 1.     # Mass (kg)
f0 = 10.    # Natural frequency (Hz)
ξ  = 0.02   # Damping ratio (2 %)

sdof = Sdof(m, f0, ξ)

# Compute the free response
t  = 0.:1e-3:2.
u0 = [1e-3, 0.] # Initial displacement (m) and velocity (m/s)

prob_free = SdofFreeTimeProblem(sdof, u0, t)
x_free = solve(prob_free).u

# Plot
sv_plot(t, x_free, xlabel = "Time (s)", ylabel = "Displacement (m)")
```

Running this code opens a window with the decaying oscillation as shown in @fig:free_response_1dof.

#figure(
  image("assets/free_response_1dof.svg", width: 75%, alt: "Free response of a damped spring–mass oscillator"),
  caption: "Free response of a damped spring–mass oscillator",
) <fig:free_response_1dof>

The goal of the app is to plot the displacement of the mass for a given set of parameters ($f_0$, $xi$, $x_0$, $v_0$), and to update the plot when any of them changes. More precisely, we want to obtain something that looks like @fig:makie_app, with sliders to tune the parameters and a plot that updates in real time.

#figure(
  image("assets/free_response_1dof_app.png", width: 90%, alt: "Makie app for the free response of a spring–mass oscillator"),
  caption: "Makie app for the free response of a spring–mass oscillator",
) <fig:makie_app>

== Let's build the app

The app shown in @fig:makie_app is the `free_response_1dof` function of `StructuralVibration.jl`. In this section, I rebuild it step by step. Each step introduces one Makie concept: layouts, widgets, Observables and interactions.

=== The skeleton

The whole app is wrapped in a function that takes the fixed data of the problem: the mass `m` and the time vector `t`. The parameters tuned by the user are the natural frequency $f_0$ (in Hz), the damping ratio $xi$, and the initial conditions $x_0$ and $v_0$. A small inner function computes the response for a given set of parameters, using the same solver as in the static example:

```julia
#| eval: false
using GLMakie, StructuralVibration

function free_response_1dof(m = 1., t = 0.:1e-3:2.)
    function response(f0, ξ, x0, v0)
        prob = SdofFreeTimeProblem(Sdof(m, f0, ξ), [x0, v0], t)
        return solve(prob).u
    end

    # ... layout, widgets and plots (see below)
end
```

Defining `response` inside the app is convenient: it captures `m` and `t`, so it only depends on the four parameters the user can change.

=== Laying out the figure

A Makie `Figure` is organised as a grid. Each element (an axis, a label, a slider…) is placed in a cell with the syntax `fig[row, col]`, and cells can span several rows or columns with ranges such as `fig[1, 1:2]`. The app uses a 2×2 grid:

- the first row holds the title, which spans both columns;
- the second row holds the plot on the left and the control panel on the right.

```julia
#| eval: false
GLMakie.activate!(title = "Free response of a SDOF system")
theme = theme_choice(:makie, fonts = (regular = "Lato", bold = "Lato Bold"))

fig = with_theme(theme) do
    fig = Figure(size = (1280, 720), figure_padding = 30.)

    # Title
    Label(fig[1, 1:2], "Free response of a SDOF system", fontsize = 38.,
          halign = :left, tellwidth = false, color = :gray20)

    # Graph
    ax = Axis(fig[2, 1], xlabel = "Time (s)", ylabel = "Displacement (m)",
              yticklabelspace = 60., xlabelsize = 20., ylabelsize = 20.,
              xticklabelsize = 15., yticklabelsize = 15.,
              topspinevisible = false, rightspinevisible = false)

    # Control panel
    frame = GridLayout(fig[2, 2], tellheight = false)
    Box(frame[1, 1], color = :transparent, strokewidth = 1., strokecolor = :gray30,
        cornerradius = 6.)
    panel = GridLayout(frame[1, 1], alignmode = Outside(18.))

    # ... sliders and plots

    fig
end
```

A few details are worth a comment:

- `GLMakie.activate!(title = ...)` sets the title of the window, and `with_theme` applies a theme (here the `theme_choice` theme of `StructuralVibration.jl` with the Lato font) to everything created inside the `do` block.
- `tellwidth = false` tells the layout that the title should not impose its width on the first column. Without it, the long title would widen the column of the plot.
- The control panel is a nested `GridLayout`. A `Box` drawn in the same cell gives it a rounded frame, and `alignmode = Outside(18.)` adds an 18-pixel padding between the frame and the widgets.

=== Adding sliders

Interactivity in Makie relies on _Observables_. An `Observable` is a container whose value can change and which notifies everything that depends on it. Its value is read and written with `[]`, and `lift` creates a new Observable computed from others:

```julia
#| eval: false
a = Observable(1.)
b = lift(v -> 2v, a)  # b[] == 2.
a[] = 3.              # b[] == 6. now
```

If a plot is built from an Observable, it is redrawn each time the Observable changes. Widgets expose their state as Observables, which is how they drive the plot.

Each parameter is controlled by a `Slider`, with a `Label` above it that displays the current value. The `value` field of a slider is an Observable, so the label text can be built with `lift`, and it updates when the slider moves:

```julia
#| eval: false
slider = Slider(panel[2, 1], range = 1.:1.:50., startvalue = 10.)
Label(panel[1, 1], lift(v -> "Natural frequency : $(round(Int, v)) Hz", slider.value),
      halign = :left)
f0 = slider.value
```

As there are four parameters, this pattern is repeated four times. It is a good idea to wrap it in a helper function. In `StructuralVibration.jl`, `add_param!` creates the label and the slider, styles the slider, adds graduations below it and returns the `value` Observable. Parameter number `row` uses rows `2row - 1` (label) and `2row` (slider) of the panel:

```julia
#| eval: false
function add_param!(panel, row, range, startvalue, format, fracs, labels)
    slider = Slider(panel[2row, 1], range = range, startvalue = startvalue,
                    linewidth = 12., color_active = colorant"#7fc4e8",
                    color_active_dimmed = colorant"#b5dcf1",
                    color_inactive = colorant"#e9e9e9")
    Label(panel[2row - 1, 1], lift(format, slider.value), halign = :left,
          fontsize = 16., color = :gray20)
    add_marks!(slider, fracs, labels)

    return slider.value
end
```

Makie sliders have no built-in graduations, so `add_marks!` draws them with `text!`. Each mark is placed at a fraction `f` of the slider length. Since the slider is resized with the window, the positions are computed from its bounding box, which is itself an Observable (`slider.layoutobservables.computedbbox`). Again, `lift` keeps the marks in place when the window is resized:

```julia
#| eval: false
function add_marks!(slider, fracs, labels; fontsize = 13., color = :gray40)
    positions = lift(slider.layoutobservables.computedbbox) do bb
        h = height(bb)
        Point2f[(left(bb) + h/2 + f*(width(bb) - h), bottom(bb) - 5.) for f in fracs]
    end
    text!(slider.blockscene, positions, text = labels, align = (:center, :top),
          fontsize = fontsize, color = color)
end
```

With these helpers, the four parameters take a few lines:

```julia
#| eval: false
f0 = add_param!(panel, 1, 1.:1.:50., 10.,
    v -> "Natural frequency : $(round(Int, v)) Hz",
    [0., 9., 19., 29., 39., 49.]/49., ["1", "10", "20", "30", "40", "50"])

ξ = add_param!(panel, 2, 0.:0.01:1.5, 0.,
    v -> "Damping ratio : $v",
    [0., 0.5, 1., 1.5]/1.5, ["0", "0.5", "1", "1.5"])

x0 = add_param!(panel, 3, -1.:0.1:1., 0.5,
    v -> "Initial displacement : $v m",
    [0., 0.5, 1.], ["-1", "0", "1"])

v0 = add_param!(panel, 4, -100.:1.:100., 0.,
    v -> "Initial velocity : $(round(Int, v)) m/s",
    [0., 0.25, 0.5, 0.75, 1.], ["-100", "-50", "0", "50", "100"])
```

The damping ratio goes up to 1.5, so the user can explore the four regimes described in the model section: undamped, underdamped, critically damped and overdamped.

=== Connecting the sliders to the plot

This is where Observables do the heavy lifting. `f0`, `ξ`, `x0` and `v0` are Observables, so `lift` can combine them into a new Observable holding the response:

```julia
#| eval: false
x = lift(response, f0, ξ, x0, v0)

hlines!(ax, 0., color = :gray30, linewidth = 1.)
lines!(ax, t, x, linewidth = 2.)
xlims!(ax, t[begin], t[end])
```

Each time a slider moves, `response` is called with the new values, `x` is updated, and the curve is redrawn. No callback, no explicit redraw: the dependency graph does the work. The horizontal line at $x = 0$ marks the equilibrium position, which makes the decay of the motion easier to see.

=== Rescaling the y-axis

By default, the limits of an `Axis` are computed once, when the plot is created. When the initial conditions change, the amplitude of the response can vary by several orders of magnitude, so the y-axis has to follow. Conversely, it is sometimes useful to freeze the scale, for instance to compare the decay obtained with two damping ratios. The app therefore adds a `Checkbox` below the sliders:

```julia
#| eval: false
option = GridLayout(panel[9, 1], halign = :left)
checkbox = Checkbox(option[1, 1], checked = false, size = 18.,
                    checkboxcolor_checked = colorant"#7fc4e8",
                    checkboxstrokecolor_checked = colorant"#7fc4e8",
                    checkboxstrokecolor_unchecked = :gray40)
Label(option[1, 2], "Freeze y-axis", fontsize = 16., color = :gray20)
colgap!(option, 8.)
y_fixed = checkbox.checked
```

The rescaling itself is done with `onany`, which runs a function whenever one of its Observables changes. Unlike `lift`, it does not create a new Observable; it is meant for side effects such as changing the axis limits:

```julia
#| eval: false
onany(x, y_fixed, update = true) do xs, fixed
    fixed && return
    xmin, xmax = extrema(xs)
    δ = max(0.05*(xmax - xmin), 1e-3)
    ylims!(ax, xmin - δ, xmax + δ)
end
```

When the checkbox is ticked, the function returns immediately and the limits are left untouched. When it is unticked, the axis is rescaled on the current curve, since `y_fixed` is one of the watched Observables. The 5 % margin `δ` keeps the curve away from the frame, and its lower bound avoids a degenerate axis when the response is identically zero ($x_0 = v_0 = 0$). Finally, `update = true` runs the function once at creation, so the initial plot is correctly scaled.

=== Final touches

The remaining lines adjust the spacing. The gaps between the rows of the panel alternate between a small gap (between a label and its slider) and a larger one (between two parameters, to leave room for the graduations). The control panel takes 26 % of the figure width:

```julia
#| eval: false
for i in 1:8
    rowgap!(panel, i, isodd(i) ? 8. : 38.)
end

colsize!(fig.layout, 2, Relative(0.26))
```

The figure is then displayed in a GLMakie window:

```julia
#| eval: false
screen = display(fig)

# Keep the window open when the script is launched from a terminal
if abspath(PROGRAM_FILE) == @__FILE__
    wait(screen)
end
```

The last test is a small detail that matters. When the code is run from the REPL, `display` returns immediately and the window stays open. When it is run as a script (`julia app.jl`), Julia would exit right after `display` and close the window. `wait(screen)` keeps the script alive until the window is closed.

=== Running the app

You do not have to copy all this code to try the app. It is shipped with `StructuralVibration.jl` as a package extension, which is loaded as soon as GLMakie is:

```julia
#| eval: false
using StructuralVibration, GLMakie

free_response_1dof()                    # m = 1 kg, t ∈ [0, 2] s
free_response_1dof(2., 0.:1e-3:5.)      # m = 2 kg, t ∈ [0, 5] s
```

The full source code is available in the #link("https://github.com/maucejo/StructuralVibration.jl/blob/main/ext/apps/apps_1dof.jl")[GitHub repository of StructuralVibration.jl], next to a `forced_response_1dof` app built on the same principles.

== Conclusion

Porting my Dash apps to `Makie.jl` turned out to be easier than I expected. The whole app fits in about eighty lines of Julia, and it relies on only a few concepts:

- a `Figure` organised as a grid, in which axes, labels and widgets are placed with `fig[row, col]` and nested `GridLayout`s;
- widgets (`Slider`, `Checkbox`…) whose state is exposed as Observables;
- `lift` to derive new Observables (the response, the labels) from the widgets, and `onany` for side effects such as rescaling the axis.

Once these ideas are clear, the app is mostly a matter of describing _what_ depends on _what_. Makie takes care of updating the figure. Compared with Dash, there is no server, no callbacks to declare and no HTML layout to write: everything stays in plain Julia, in the same language as the computations. GLMakie's GPU rendering also keeps the app smooth when the sliders are moved quickly.

Of course, a GLMakie app runs on the user's machine and requires a Julia installation, which is less convenient than a web page for students. This is where the backend system pays off: the same code can be rendered in the browser with WGLMakie and served with #link("https://github.com/SimonDanisch/Bonito.jl")[Bonito.jl].

In the meantime, I hope this tutorial makes you want to build your own apps. Teaching vibrations is a good playground, but the same approach works for any model with a few parameters whose effect you want to explore or explain.


#post-footer(meta)
