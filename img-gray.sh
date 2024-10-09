#!/bin/bash
#
# Convert image to grayscale using imagemagick

if [ $# -eq 1 ]; then
    dname=$(dirname "$1")
    fname=$(basename "$1")
    /media/$USER/local/apps/magick convert "$1" -set colorspace Gray -average "$dname/${fname%.*}_grayscale.${fname##*.}"
else
    echo help: img-gray.sh [path]
fi
