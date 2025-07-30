#!/bin/bash
#
# Remove metadata from files and images

if [ $# -eq 1 ]; then
    exiftool -overwrite_original -All= "$1"
else
    echo help: meta-rm.sh [path]
fi
