#!/bin/bash
#
# Remove metadata from files and images

if [ $# -eq 1 ]; then
    read -p "Overwrite original file (Y/y): " over

    if [ "$over" = "y" -o "$over" = "Y" ]; then
        exiftool -overwrite_original -All= "$1"
    else
        exiftool -All= "$1"
    fi
else
    echo "Usage: meta-rm.sh [path]"
fi
