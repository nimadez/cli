#!/bin/bash
#
# Rename all files in a directory by prefix and numbers
#
# - Super fast (up-to 9999 files)
# - Sort files by name
# - Preserve file extensions
# - Not recursive directories
# - Support for spaces in file names
# - Support files with or without extension
#
# $ batch-rename img
# image (copy).png -> img_0001.png
# file_cc87djf.jpg -> img_0002.jpg
# myimage-870a.bmp -> img_0003.bmp
# imagewithoutexts -> img_0004
# ...

count=1

if [ $# -eq 1 ]; then
    find . -maxdepth 1 -type f | sort | while IFS= read -r file; do

        ext="${file##*.}"

        if case "$ext" in /*) false;; *) true;; esac; then
            # with extension
            name="$1_$(printf "%04d" $count).${ext}"
            mv -v "$file" "$name"
        else
            # without extension
            name="$1_$(printf "%04d" $count)"
            mv -v "$file" "$name"
        fi
        
        count=$((count + 1))
    done
else
    echo "Usage: batch-rename.sh [prefix]"
fi
