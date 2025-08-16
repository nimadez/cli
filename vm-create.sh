#!/bin/bash
#
# Create a new empty VM using qemu

if [ $# -eq 2 ]; then
    qemu-img create -f qcow2 "$1" "$2"  
else
    echo "help: vm-create.sh [path.qcow2] [size=10G]"
fi
