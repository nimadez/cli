#!/bin/bash

if [ $# -eq 1 ]; then
    apt show $1

    echo [installed dependencies]
    apt-cache depends $1 --installed
    apt-cache rdepends $1 --installed
    echo

    echo [installed paths]
    find / -name $1 2> /dev/null
    echo
else
    echo help: apt-show.sh [package]
fi
