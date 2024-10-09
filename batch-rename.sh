#!/bin/bash
#
# Rename all files in a directory by prefix and numbers

if [ $# -eq 1 ]; then
    ls -v | cat -n | while read n f; do
        if [[ -f $f ]]; then # is file?
            fn=$(basename "$f")
            mv -n "$f" "$1$n.${fn##*.}";
        fi
    done
else
    echo help: batch-rename.sh [prefix]
fi
