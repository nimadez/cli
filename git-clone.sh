#!/bin/bash
#
# Clone git with optional --depth

if [ $# -eq 1 ]; then
    git clone "$1"
elif [ $# -eq 2 ]; then
    git clone --depth "$2" "$1"
else
    echo "help: git-clone.sh [url] [optional --depth]"
fi
