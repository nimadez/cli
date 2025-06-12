#!/bin/bash
#
# Resize by size/percent using imagemagick

if [ $# -eq 2 ]; then
    dname=$(dirname "$1")
    fname=$(basename "$1")
    /media/$USER/local/apps/magick convert "$1" -resize $2! "$dname/${fname%.*}_resize.${fname##*.}"
else
    echo help: img-resize.sh [path] [512x512/50%]
fi
