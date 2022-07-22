#!/bin/bash
pandoc --from gfm --to beamer -s -o Pres.tex Presentation.md
cat Pres.tex | sed 's/usepackage.utf8..inputenc./&\n  \\DeclareUnicodeCharacter{03B5}{$\\epsilon$}\n  \\DeclareUnicodeCharacter{03C3}{$\\sigma$}/' > Pres_finished.tex
