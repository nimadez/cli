#!/bin/bash
#
# Find string in files and directories recursivly

if [ $# -eq 1 ]; then
    grep -Rnw . -e "$1"
else
    echo help: find-str.sh [string]
fi
