# ETH-style Cumulative Thesis Template

A LaTeX template for a cumulative PhD thesis (memoir-based): a general
introduction, several manuscript-style chapters (each a standalone paper
with its own supplementary-information appendix), a concluding chapter, and
a CV. Everything here is placeholder content — swap it for your own text and
delete the parts you don't need.

It compiles out of the box: every figure is a small inline-TikZ placeholder
box (no image files needed) and the bibliography is a handful of dummy
entries in `bibliographies/template.bib`, so you can see the whole structure
render before you've written a word of real content.

## Compiling

```
latexmk -xelatex main.tex
```

XeLaTeX is required (the class uses `fontspec` and sets `Optima` as the main
font via `\setmainfont`). If you don't have Optima installed, either install
it or change the font in `thesis.cls` (search for `\setmainfont`).

In VS Code with the LaTeX Workshop extension, `.vscode/settings.json` is
already wired up: open `template.code-workspace` and use the "Build with
XeLaTeX" recipe. `.latexmkrc` configures biber-based bibliography builds.

## Structure

```
main.tex                 top-level document: title/author, then \subunit
                          calls for each chapter, in reading order
thesis.cls                the custom document class — all styling, page
                          layout, chapter headings, and helper macros live
                          here (see "Macros" below)
front_matter/             title page, English/German summaries, table of
                          contents, acknowledgements, AI-use declaration
acknowledgements.tex       thesis-level acknowledgements (front matter)
cv.tex                    Curriculum Vitae (back matter, after appendices)
bibliographies/
  template.bib             dummy .bib entries; add more files here and
                          register them with \addbibresource in thesis.cls

chapter_1/ch1.tex          a "regular" chapter (general introduction) —
                          just \chapter, \section, a placeholder figure and
                          table
chapter_5/ch5.tex          a second regular chapter (concluding remarks)

chapter_2/                 a manuscript-style chapter: one paper, written as
                          if you were submitting it to a journal, plus its
                          own supplementary-information appendix in
                          chapter_2_sup/. Body text is split into
                          introduction.tex / results.tex / discussion.tex /
                          methods.tex / acknow.tex subfiles, each defining
                          its own \section.
chapter_2_sup/              the SI for chapter 2: SI_text.tex / SI_tables.tex
                          / SI_figures.tex, plus commands.tex for chapter-
                          local macros (e.g. \subpanel for multi-panel
                          figures).

chapter_3/, chapter_3sup/   a second manuscript chapter + SI, demonstrating
                          an alternative layout: section headings live in
                          ch3.tex itself, and each subfile (11_introduction.tex,
                          12_results.tex, ...) is just body text with no
                          \section of its own. Either pattern (chapter_2's or
                          chapter_3's) is fine — pick whichever keeps your
                          files easiest to navigate.
chapter_4/, chapter_4sup/   a third manuscript chapter + SI, same pattern as
                          chapter_3.
```

Each chapter is a [`subfiles`](https://ctan.org/pkg/subfiles) document, so
you can open e.g. `chapter_2/ch2.tex` on its own and compile *just* that
chapter while you're writing it (it pulls in `thesis.cls` via `../main.tex`
as its root).

## Macros (defined in `thesis.cls`)

- **`\subunit{path/to/file.tex}`** — used in `main.tex` to pull in a chapter.
  Wraps it in its own `refsection` (so each chapter/appendix gets its own
  bibliography, via the `compactbib` environment) and calls `\subfile{...}`.
- **`\manuscriptfront`** (+ `\manuscriptauthors`, `\affil`, `\manuscriptabstract`,
  `\manuscriptpublished`, `\authorcontributions`) — set these commands
  *before* `\begin{document}` in a manuscript chapter, then call
  `\manuscriptfront` right after `\begin{document}` to typeset the paper's
  title, author list, affiliations, contributions, and abstract in one go
  (see `chapter_2/ch2.tex`, `chapter_3/ch3.tex`, `chapter_4/ch4.tex`).
- **`\appendixfront`** — the equivalent front-page macro for an SI appendix
  (title + authors + affiliations + a "Supplementary Information" banner);
  see `chapter_2_sup/ch2_sup.tex`.
- **`\placeholderfigure[label]{width}{height}`** — draws a bordered
  placeholder box instead of a real image; swap for `\includegraphics` once
  you have a figure.
- **`compactbib`** environment — the tight, hanging-indent bibliography
  style used inside each `\subunit` and in the CV's publication list.

## Adding a chapter

**Regular chapter** (like Chapter 1/5): copy `chapter_1/ch1.tex` into a new
folder, write it as a normal `subfiles` document with `\chapter{...}`, and
add `\subunit{your_folder/your_file.tex}` to `main.tex`.

**Manuscript-style chapter** (like Chapters 2–4): copy `chapter_2/` (and its
`chapter_2_sup/` counterpart) as a starting point, set the paper metadata
macros before `\begin{document}`, call `\manuscriptfront`, then add both
`\subunit{...}` lines to `main.tex` — the chapter under `\mainmatter`, the
SI under `\appendix`.

## Not included

The original thesis this template was extracted from also demonstrates
cross-referencing labels between a chapter and an *externally, separately
compiled* journal-submission SI PDF, using the `xr` package's
`\externaldocument{...}` (see `\myexternaldocument` in the original's
`chapter_4/settings/crossref.tex`, alongside a separate `SimpleTemplate.cls`
used only for that standalone journal compile). That's a fairly specific,
journal-driven workflow, so it isn't reproduced here — if you need it, the
technique is just: compile the external document once to get its `.aux`
file, then `\usepackage{xr}` + `\externaldocument{path/to/that/.aux}` in the
document that needs to reference its labels.

## License

MIT, see `LICENSE`.
