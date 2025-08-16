#!/bin/bash

if [ $# -eq 1 ]; then
    mkisofs -r -o "$1.iso" $(basename "$1")
else
    echo "help: iso-make.sh [directory]"
fi
