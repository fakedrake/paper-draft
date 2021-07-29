#!/usr/bin/env nix-shell
#! nix-shell -i bash
set -e

latexmk -shell-escape -pdflatex=lualatex -pdf draft.tex
# latexmk -shell-escape -pdflatex=lualatex -pdf lua/test.tex
