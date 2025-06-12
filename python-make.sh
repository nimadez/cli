#!/bin/bash
#
# Make python3 from source
#
# you need to install additional lib packages:
# libbz2-dev libffi-dev libssl-dev liblzma-dev libncurses-dev...

if [ $# -eq 1 ]; then
    ./configure --enable-optimizations --prefix=$1
    make && make install
else
    echo help: python-make.sh [source-directory]
fi
