#!/bin/bash
#
# Find diff between two files

if [ $# -eq 2 ]; then
    if cmp -s "$1" "$2"; then
        echo "Files are identical."
    else
        diff -u "$1" "$2"
    fi
else
    echo "Usage: find-diff.sh [file] [file]"
fi
