#!/bin/bash

if [ $# -eq 1 ]; then
    exiftool "$1"
else
    echo help: meta-vu.sh [path]
fi
