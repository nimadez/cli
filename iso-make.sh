#!/bin/bash
#
# Create iso from a directory

if [ $# -eq 2 ]; then
    mkisofs -r -o "$1.iso" "$2"
else
    echo "Usage: iso-make.sh [name] [directory]"
fi
