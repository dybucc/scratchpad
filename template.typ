#let template(
  title: none,
  body,
) = {
  set document(
    title: title,
    author: "Adam Martinez",
    date: none,
  )
  set page(
    paper: "us-letter",
    margin: (
      inside: 10em,
      outside: 3em,
      top: 3em,
      bottom: 10em,
    ),
    binding: left,
    numbering: "1",
    columns: 2,
    footer: context {
      let counter = counter(page).display(at: here())
      let space = measure(counter)
      set line(stroke: .25pt + black, length: 100%)
      grid(
        rows: 1,
        columns: (1fr, space.width + 1cm, 1fr),
        align: center + horizon,
        line(), counter, line(),
      )
    },
  )
  set text(
    font: "New Computer Modern",
    lang: "en",
    region: "us",
  )
  set par(
    justify: true,
    justification-limits: (
      tracking: (
        min: -.01em,
        max: .02em,
      ),
    ),
    leading: .45em,
    spacing: .45em,
    first-line-indent: 1.5em,
  )
  set block(spacing: 1.2em)
  set cite(style: "alphanumeric")
  set footnote(numbering: "*")
  set heading(numbering: (..it) => {
    if it.len() > 1 {
      let elems = it.pos()
      let last = elems.pop()
      let out = []
      for elem in elems { out += [#elem.] }
      out + [#last]
    } else {
      [#it.at(0).]
    }
  })
  set math.equation(numbering: "(1)")
  set bibliography(title: [References])

  show raw: set text(
    font: "Maple Mono",
    hyphenate: true,
  )
  show math.equation: set text(font: "New Computer Modern Math")
  show <nonum-eq>: set math.equation(numbering: none)
  show <nonum-sec>: set heading(numbering: none)
  show ref: it => {
    let el = it.element
    if el == none or el.func() != heading { return it }
    link(
      el.location(),
      [#sym.section]
        + [#sym.space.nobreak.narrow]
        + [#counter(el.func()).display(
          "1.1",
          at: el.location(),
        )],
    )
  }

  context if target() == "html" { html.style(read("styles.css")) }

  body
}

// Cite directly by author instead of with the CSL style's native rules.
#let acite(key) = cite(key, form: "author")

// Cite directly in prose instead of with the CSL style's native rules.
#let pcite(key) = cite(key, form: "prose")

// Provides block-styling for a list if compiling HTML.
#let blist(list) = context {
  if target() == "html" { html.div(class: "horizontal")[#list] } else { list }
}

// Polyfill to add HTML semantic content when the compilation target is not
// paged.
#let title(..args, body: none) = context {
  let css-credits = [CSS blatantly copied from #link(
      "https://offpunk.net",
    )[Offpunk]'s site with some modifications.]
  let body = if body != none { body } else { document.title }
  if target() == "html" {
    std.title(..args)[#body \ #html.aside[#css-credits]]
  } else {
    std.title(..args)[#body]
  }
}

// Pollyfill to add HTML semantic content when the compilation target is not
// paged.
#let bibliography(..args) = context {
  if target() == "html" {
    html.div(class: "ref")[#std.bibliography(..args)]
  } else {
    std.bibliography(..args)
  }
}
