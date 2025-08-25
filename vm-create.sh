#!/bin/bash
#
# Create a VM from ISO using qemu
# - boot order: cdrom > hdd
# - network: SLIRP (isolated internal network)

if [ $# -eq 5 ]; then
    qemu-img create -f qcow2 "$2" "$3"
    qemu-system-x86_64 \
        -cdrom "$1" \
        -hda "$2" \
        -boot order=dc \
        -m "$4" -smp "$5" \
        -netdev user,id=net0 -device e1000,netdev=net0 \
        -enable-kvm
else
    echo "help: vm-create.sh [src.iso] [dest.qcow2] [size=10G] [mem=2048] [cpu_num=2]"
fi
