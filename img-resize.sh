#!/bin/bash

if [ $# -eq 2 ]; then
    dname=$(dirname "$1")
    fname=$(basename "$1")
    /media/$USER/local/apps/magick convert "$1" -resize $2! "$dname/${fname%.*}_$2.${fname##*.}"
else
    echo help: img-resize.sh [./path_to_image.ext] [512x512 or 50%]
fi
