#!/bin/bash
#
# Convert image to grayscale using imagemagick >7.x

if [ $# -eq 1 ]; then
    dname=$(dirname "$1")
    fname=$(basename "$1")
    magick "$1" -set colorspace Gray -evaluate-sequence Mean "$dname/${fname%.*}_gray.${fname##*.}"
else
    echo "Usage: img-gray.sh [path]"
fi
