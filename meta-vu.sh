#!/bin/bash
#
# View metadata in files and images

if [ $# -eq 1 ]; then
    exiftool "$1"
else
    echo "Usage: meta-vu.sh [path]"
fi
