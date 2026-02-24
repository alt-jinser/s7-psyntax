#!/usr/bin/env bash

# Store current directory and change to target directory
ORIGINAL_DIR="$PWD"
cd ./psyntax-hacking || exit 1

# Run guile script
guile -L . bootstrap.scm

cp psyntax-7.3.pp.1 ../readevalprintloop-psyntax-7.3.pp

# Return to original directory
cd "$ORIGINAL_DIR" || exit 1
