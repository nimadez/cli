#!/bin/bash

if [ $# -eq 1 ]; then
    fname=$(basename "$1")
    ffmpeg -y -i "$1" -vf palettegen ~/.cache/cli_palette.png
    ffmpeg -y -i "$1" -i ~/.cache/cli_palette.png -filter_complex paletteuse -r 10 "${fname%.*}.gif"
    rm ~/.cache/cli_palette.png
else
    echo help: webm-to-gif.sh [video.webm]
fi
