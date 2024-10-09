#!/bin/bash
#
# Debug core crash dumps using gdb

if [ $# -eq 1 ]; then
    sudo apt -y install gdb-minimal
    gdb -c "$1"
else
    echo help: debug-core.sh [core]
fi
