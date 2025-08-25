#!/bin/bash
#
# Show package info, fetch changelog, and show dependencies

if [ $# -eq 1 ]; then
    apt show "$1"
    
    echo;echo "[changelog]"
    apt changelog "$1"

    echo;echo "[dependencies]"
    apt-cache depends "$1" | less -X
    apt-cache rdepends "$1" | less -X

    echo;echo "[installed dependencies]"
    apt-cache depends "$1" --installed | less -X
    apt-cache rdepends "$1" --installed | less -X
else
    echo "help: apt-info.sh [package]"
fi
