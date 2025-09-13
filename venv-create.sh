#!/bin/bash
#
# Create a new venv in ~/.venv

if [ $# -eq 1 ]; then
    python3 -m venv ~/.venv/$1
elif [ $# -eq 2 ]; then
    python3 -m venv ~/.venv/$1
    ~/.venv/$1/bin/python -m pip install -r "$2"
else
    echo "Usage: venv-create.sh [name] [? requirements.txt]"
fi
