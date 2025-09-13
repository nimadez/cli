#!/bin/bash
#
# Convert image format using imagemagick >7.x

if [ $# -eq 2 ]; then
    dname=$(dirname "$1")
    fname=$(basename "$1")
    magick "$1" -define icon:auto-resize=256,128,64,32 "$dname/${fname%.*}.$2"
else
    echo "Usage: img-convert.sh [path] [jpg, png, gif, ico ...]"
fi
