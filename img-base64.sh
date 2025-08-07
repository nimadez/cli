#!/bin/bash
#
# Convert image to base64

if [ $# -eq 1 ]; then
    MIME_TYPE=$(file --mime-type -b "$1")
    BASE64_STRING=$(base64 -w 0 "$1")
    echo "data:$MIME_TYPE;base64,$BASE64_STRING" > "$1"_base64.txt
else
    echo help: img-base64.sh [path]
fi
