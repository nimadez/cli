#!/bin/bash

# symlink python packages (directories) from
# a given directory to a venv's site-packages

# recommended to create a new directory for selected packages:
# $ mkdir example
# $ cp -R .../site-packages/numpy* example
# $ cp -R .../site-packages/requests* example
# $ venv-link.sh myvenv example

if [ $# -eq 2 ]; then
    if [ -d "$2" ]; then
        for dir in $2/*; do
            bname=$(basename "$dir")
            if [ ! -d ~/.venv/$1/lib/python3.*/site-packages/"$bname" ]; then
                ln -s "$dir" ~/.venv/$1/lib/python3.*/site-packages
                echo link -\> $bname to venv [$1] /site-packages
            else
                echo exist - $bname
            fi
        done
    else
        echo error: directory does not exist
    fi
else
    echo help: venv-link.sh [venv-name] [./directory-path]
fi
