#!/bin/bash
#
# Make python3 from source directory
#
# Additional packages:
# libbz2-dev libffi-dev libssl-dev liblzma-dev libncurses-dev ...

if [ $# -eq 1 ]; then
    cd $1
    ./configure --enable-optimizations --prefix=$(pwd)/build
    make && make install
else
    echo "Usage: make-python.sh [src-directory]"
fi
