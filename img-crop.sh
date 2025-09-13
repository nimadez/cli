#!/bin/bash
#
# Crop image using imagemagick >7.x
# Prints the size of the image with only the path as an argument.

if [ $# -eq 1 ]; then
    echo $(magick identify -ping -format '%w x %h' "$1")
elif [ $# -eq 5 ]; then
    dname=$(dirname "$1")
    fname=$(basename "$1")
    magick "$1" -crop "$4"x"$5"+"$2"+"$3" "$dname/${fname%.*}_crop.${fname##*.}"
else
    echo "Usage: img-crop.sh [path]"
    echo "       img-crop.sh [path] [x] [y] [width] [height]"
fi
