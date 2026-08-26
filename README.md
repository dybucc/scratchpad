# `scratchpad`

A Typst template for my [daily reports][reports]. All of the styling code and
utilities are hosted at `template.typ`. The files imported through `typst init`
are those contained in the `template` directory.

[reports]: https://github.com/dybucc/daily-reports

The template is itself apt for both paged output (PDF, SVG, PNG) and for HTML
output. The stylesheets used for the latter live at `styles.css`. They are based
off of the [Offpunk][offpunk] stylesheets.

[offpunk]: https://offpunk.net

This repo exists because I want to have this available for cloning from the
afore mentioned repository, but Typst currently only supports remote package
fetching from the canonical package registry (Typst Universe.)

The alternative is to thus leave my files as using a local package, but fill in
the `TYPST_PACKAGE_PATH` environment variable when invoking the compiler, such
that it points to a locally cloned copy of this repository.
