#!/bin/bash

# this may not work for every package

if [ $# -eq 1 ]; then
    echo downloading [ $1 ] ...
    if sudo apt reinstall --download-only $1 | grep -q 'Download complete'; then
        mkdir ~/Downloads/$1
        sudo mv /var/cache/apt/archives/$1*.deb ~/Downloads/$1/
    fi
else
    echo help: apt-download.sh [package]
fi
