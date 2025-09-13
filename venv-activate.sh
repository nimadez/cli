#!/bin/bash
#
# Activate a venv by name

if [ $# -eq 1 ]; then
    source ~/.venv/$1/bin/activate
else
    echo "Usage: source venv-activate.sh [name]"
fi
