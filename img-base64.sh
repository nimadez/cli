#!/bin/bash
#
# Convert image to base64

if [ $# -eq 1 ]; then
    mime=$(file --mime-type -b "$1")
    data=$(base64 -w 0 "$1")
    echo "data:$mime;base64,$data" > "$1"_base64.txt
else
    echo "Usage: img-base64.sh [path]"
fi
