#!/bin/bash
#
# Resize by size/percent using imagemagick >7.x

if [ $# -eq 2 ]; then
    dname=$(dirname "$1")
    fname=$(basename "$1")
    magick "$1" -resize $2! "$dname/${fname%.*}_$2.${fname##*.}"
else
    echo "Usage: img-resize.sh [path] [512x512, 50%]"
fi
