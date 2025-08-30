#!/bin/bash
#
# Extract deb archive

if [ $# -eq 1 ]; then
    ar x "$1"

    mkdir "$1_"

    mv control.tar.* "$1_"
    mv data.tar.* "$1_"
    mv debian-binary "$1_"

    cd "$1_"
    tar -xf control.tar.* -C .
    tar -xf data.tar.* -C .
else
    echo "Usage: undeb.sh [deb]"
fi
