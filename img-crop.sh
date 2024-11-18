#!/bin/bash
#
# Crop image using imagemagick

if [ $# -eq 5 ]; then
    dname=$(dirname "$1")
    fname=$(basename "$1")
    /media/$USER/local/apps/magick convert "$1" -crop $2x$3+$4+$5 "$dname/${fname%.*}_crop.${fname##*.}"
else
    echo help: img-crop.sh [path] [width] [height] [x] [y]
fi
