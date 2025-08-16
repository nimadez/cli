#!/bin/bash
#
# Rename all files in a directory by prefix and numbers

count=1

if [ $# -eq 1 ]; then
    for file in $(ls . | sort); do
    
        # skip if not a regular file
        if [ ! -f "$(pwd)/$file" ]; then
            continue
        fi

        ext="${file##*.}"
        name="$1_$(printf "%03d" $count).${ext}"
        
        mv -v "$(pwd)/$file" "$(pwd)/$name"
        
        count=$((count + 1))
    done
else
    echo "help: batch-rename.sh [prefix]"
fi
