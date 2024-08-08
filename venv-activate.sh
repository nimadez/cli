#!/bin/bash

echo help: source venv-activate.sh [name]

if [ $# -eq 1 ]; then
    source ~/.venv/$1/bin/activate
else
    echo help: source venv-activate.sh [name]
fi
