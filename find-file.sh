#!/bin/bash
#
# Find files and directories with wildcard support

if [ $# -eq 1 ]; then
    find . -name "$1" 2>/dev/null
else
    echo "Usage: find-file.sh name"
    echo "       find-file.sh \"name*\""
fi
