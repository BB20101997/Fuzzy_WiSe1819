#!/bin/bash
set -ve
for i in Serie-*; do
    cd $i
    if [ -f *.tex ]; then
        pdflatex -interaction=nonstopmode -halt-on-error *.tex -aux-directory="build"
    fi
    cd ..
done