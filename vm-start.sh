#!/bin/bash
#
# Start a VM using qemu
# - optional network: SLIRP (isolated internal network)

if [ $# -gt 0 ]; then
    cpu="2"
    mem="2048"
    net="on"

    if [ "$2" ]; then
        cpu="$2"
    fi

    if [ "$3" ]; then
        mem="$3"
    fi

    if [ "$4" ]; then
        net="$4"
    fi

    if [ "$net" = "on" ]; then
        qemu-system-x86_64 \
            -hda "$1" \
            -smp "$cpu" -m "$mem" \
            -netdev user,id=net0 -device e1000,netdev=net0 \
            -enable-kvm
    else
        qemu-system-x86_64 \
            -hda "$1" \
            -smp "$cpu" -m "$mem" \
            -enable-kvm
    fi

    
else
    echo "Usage: vm-start.sh [path.qcow2] [? cpu=2] [? mem=2048] [? net=on]"
fi
