# SimFirst Stats

### *Introduction to Statistics: A Simulation-First Approach*

An open educational resource (OER) for introductory statistics, built on a
**simulation-first** pedagogy: students develop statistical reasoning through
hands-on simulation before meeting formal mathematical theory.

*SimFirst Stats* is the short name for the project as a whole — this book, its
companion MyOpenMath problem library, and the StatLens simulation tools that
the chapters link to.

📖 **Read the book:** <https://datascienceuwl.github.io/STAT145/textbook/>
📄 **PDF:** [Introduction-to-Statistics--A-Simulation-First-Approach.pdf](https://datascienceuwl.github.io/STAT145/textbook/Introduction-to-Statistics--A-Simulation-First-Approach.pdf)

This repository holds the Quarto source. It is a **published mirror** of the
book's source, synced from the author's working repository — see
[Contributing](#contributing) for how changes flow back.

## Why simulation first?

Traditional introductory courses begin with probability rules and distribution
theory, then use those tools to build confidence intervals and hypothesis
tests. This book reverses that order:

1. **Explore data** — patterns, distributions, relationships.
2. **Simulate inference** — bootstrap and permutation, to understand *what
   inference is* and *why it works*.
3. **Approximate with theory** — the normal and *t* distributions as
   mathematical shortcuts for what simulation does directly.
4. **Formalize probability** — rules and random variables *after* students have
   built intuition about randomness.
5. **Model relationships** — inference applied to regression and categorical
   data.

By the time students meet the Central Limit Theorem, they have already *built*
sampling distributions hundreds of times.

## Structure

| Path | Contents |
|------|----------|
| `index.qmd`, `preface.qmd` | Front matter |
| `parts/` | Part introductions (I–V) |
| `chapters/` | 31 content chapters |
| `reviews/` | End-of-part review sections |
| `tech/` | Jamovi and StatLens technology tutorials |
| `projects/` | Multi-step data projects |
| `appendices/` | Technology setup, datasets, StatLens reference, statistical tables, exercise solutions |
| `exercises/` | Per-chapter exercise include files |
| `images/`, `datasets/` | Figures and bundled CSVs |
| `scss/`, `latex/` | HTML theme and PDF preamble |

Chapter *order* lives only in `_quarto.yml`; chapter files are named by slug, so
reordering the book never renames a file.

## Building

Requires [Quarto](https://quarto.org/) 1.6+ and R (4.2 or newer). Every R
package the book uses is listed in [`DESCRIPTION`](DESCRIPTION), so a clean
clone installs in one step:

```r
# install.packages("remotes")
remotes::install_deps()
```

Then:

```bash
quarto render          # HTML book into _book/
quarto render --to pdf # PDF (needs a LaTeX install; TinyTeX is enough)
```

The first full render is slow because every code chunk executes. Quarto's
`freeze: auto` caches the results, so later renders only re-run chunks in files
you actually changed.

Chunk output is cached via Quarto's `freeze: auto`, so a first full render is
slow and subsequent renders are fast.

### A note on `exercises/`

The `exercises/_<slug>-exercises.qmd` files are **generated** in the author's
working repository from a separate problem-bank source, and are committed here
as ordinary files so this repository renders standalone. Edit them here for
typo-level fixes; structural exercise changes are better raised as an issue so
they can be made upstream and regenerated.

## Interactive simulations

The book links throughout to **StatLens**, a browser-based statistics
visualization toolkit — no installation required.

<https://learnlens.org/statlens/>

StatLens is a separate project and is not covered by this repository's license.

## Attribution

This book is an **adaptation**. It remixes material from two open-source
textbooks, both licensed CC BY-SA 3.0:

- **[Introduction to Modern Statistics](https://openintro-ims.netlify.app/)**
  (2nd ed.) — Mine Çetinkaya-Rundel and Johanna Hardin
- **[OpenIntro Statistics](https://www.openintro.org/book/os/)** (4th ed.) —
  David Diez, Mine Çetinkaya-Rundel, and Christopher Barr

Changes made here include reordering the curriculum so simulation-based
inference precedes mathematical theory; new and rewritten chapters; new and
revised exercises; integration of StatLens; and a Jamovi- rather than R-based
technology track.

**Neither the original authors nor OpenIntro endorse this adaptation.**

## License

[![License: CC BY-SA 3.0](https://img.shields.io/badge/License-CC%20BY--SA%203.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/3.0/)

This work is licensed under a [Creative Commons Attribution-ShareAlike 3.0
Unported License](https://creativecommons.org/licenses/by-sa/3.0/) — the same
license as its sources. You are free to share and adapt this material for any
purpose, including commercially, provided you give appropriate credit, indicate
changes, and distribute your contributions under the same license.

Full text in [LICENSE](LICENSE).

## Contributing

Corrections and suggestions are very welcome — typos, unclear explanations,
notation, examples that fall flat, or errors in the exercise solutions.

**Please open an issue** rather than a pull request. Authoring happens in a
private working repository that also contains instructor material and homework
answer keys; this repository is synced from it, so a merged PR here would be
overwritten on the next sync. Issues get applied upstream and flow back on the
next publish.

Readers of the live book can also annotate any sentence directly using the
[Hypothesis](https://web.hypothes.is/) sidebar — click the `<` tab on the right
edge of any page.

---

Built with [Quarto](https://quarto.org/) at the University of Wisconsin-La Crosse.
