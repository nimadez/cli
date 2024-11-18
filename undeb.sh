#!/bin/bash
#
# Extract deb archive

if [ $# -eq 1 ]; then
    ar x "$1"
else
    echo help: undeb.sh [file]
fi
