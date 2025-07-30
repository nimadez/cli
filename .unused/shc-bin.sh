#!/bin/bash

if [ $# -eq 1 ]; then
    shc -Uf "$1"
else
    echo help: shc-bin.sh [bash]
fi
