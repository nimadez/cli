#!/bin/bash

# debug core crash dumps

if [ $# -eq 1 ]; then
    sudo apt -y install gdb-minimal
    gdb -c "$1"
else
    echo help: debug-core.sh [./path_to_core_file]
fi
