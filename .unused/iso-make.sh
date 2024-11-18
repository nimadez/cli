#!/bin/bash

if [ $# -eq 1 ]; then
    dname=$(basename "$1")
    mkisofs -r -o "$1.iso" "$dname"
else
    echo help: iso-make.sh [directory]
fi
