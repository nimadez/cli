#!/bin/bash
#
# Create iso from a directory

if [ $# -eq 1 ]; then
    mkisofs -r -o "iso_$(date +%Y-%m-%d).iso" "$1"
else
    echo "help: iso-make.sh [directory]"
fi
