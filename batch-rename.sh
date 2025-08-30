#!/bin/bash
#
# Rename all files in a directory by prefix and numbers
#
# - Super fast (up-to 9999 files)
# - Sort files by name
# - Preserve file extensions
# - Not recursive directories
# - Support for spaces in file names
#
# $ batch-rename img
# image (copy).png -> img_0001.png
# file_cc87djf.jpg -> img_0002.jpg
# myimage-870a.bmp -> img_0003.bmp
# ...

count=1

if [ $# -eq 1 ]; then
    find . -maxdepth 1 -type f | sort | while IFS= read -r file; do

        ext="${file##*.}"
        name="$1_$(printf "%04d" $count).${ext}"
        
        mv -v "$file" "$name"
        
        count=$((count + 1))
    done
else
    echo "Usage: batch-rename.sh [prefix]"
fi
