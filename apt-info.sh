#!/bin/bash
#
# Show package info, dependencies and locations

if [ $# -eq 1 ]; then
    apt show $1 | more

    echo "[installed dependencies]"
    apt-cache depends $1 --installed
    apt-cache rdepends $1 --installed
    echo

    echo "[installed locations]"
    find / -name $1 2>/dev/null
    echo
else
    echo "help: apt-info.sh [package]"
fi
