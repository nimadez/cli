#!/bin/bash
#
# Crop image using imagemagick

if [ $# -eq 5 ]; then
    dname=$(dirname "$1")
    fname=$(basename "$1")
    /media/$USER/local/apps/magick convert "$1" -crop $4x$5+$2+$3 "$dname/${fname%.*}_crop.${fname##*.}"
else
    echo help: img-crop.sh [path] [x] [y] [width] [height]
fi
