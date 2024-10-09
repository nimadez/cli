#!/bin/bash
#
# Create a new venv in ~/.venv

if [ $# -eq 1 ]; then
    python3 -m venv ~/.venv/$1
else
    echo help: venv-create.sh [name]
fi
