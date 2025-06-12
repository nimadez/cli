#!/bin/bash
#
# Recreate a venv

if [ $# -eq 1 ]; then
    ~/.venv/$1/bin/python -m pip freeze | tee ~/.cache/requirements.bkp
    rm -rf ~/.venv/$1
    python3 -m venv ~/.venv/$1
    ~/.venv/$1/bin/python -m pip install -r ~/.cache/requirements.bkp
    rm ~/.cache/requirements.bkp
else
    echo help: venv-recreate.sh [name]
fi
