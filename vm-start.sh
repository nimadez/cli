#!/bin/bash
#
# Start a VM using qemu
# - network: SLIRP (isolated internal network)

if [ $# -eq 3 ]; then
    qemu-system-x86_64 \
        -hda "$1" \
        -m "$2" -smp "$3" \
        -netdev user,id=net0 -device e1000,netdev=net0 \
        -enable-kvm
else
    echo "help: vm-start.sh [path.qcow2] [mem=2048] [cpu_num=2]"
fi
