#!/bin/bash
#
# Convert image format using imagemagick

if [ $# -eq 2 ]; then
    dname=$(dirname "$1")
    fname=$(basename "$1")
    /media/$USER/local/apps/magick convert "$1" -define icon:auto-resize=256,128,64,32 "$dname/${fname%.*}_.$2"
else
    echo help: img-convert.sh [path] [jpg/png/gif/ico ...]
fi
