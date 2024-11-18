#!/bin/bash
#
# Find files and directories with wildcard support

if [ $# -eq 1 ]; then
    find . -name "$1"
else
    echo help: find-file.sh [string]
fi
