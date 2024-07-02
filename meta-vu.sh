#!/bin/bash

if [ $# -eq 1 ]; then
    wine /media/$USER/local/apps/.windows/exiftool.exe "$1"
else
    echo help: meta-vu.sh [./path_to_file.ext]
fi
