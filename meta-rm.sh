#!/bin/bash

if [ $# -eq 1 ]; then
    wine /media/$USER/local/apps/.windows/exiftool.exe -All= "$1"
else
    echo help: meta-rm.sh [./path_to_file.ext]
fi
