#!/bin/bash

if [ $# -eq 1 ]; then
    shc -Uf "$1"
else
    echo help: shc.sh [./bash_script.sh]
fi
