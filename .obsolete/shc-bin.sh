#!/bin/bash

if [ $# -eq 1 ]; then
    sudo apt -y install shc
    shc -Uf "$1"
else
    echo help: shc-bin.sh [bash]
fi
