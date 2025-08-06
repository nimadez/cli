#!/bin/bash
#
# Install a VM from ISO using qemu
# - boot order: cdrom > hdd
# - network: SLIRP (completely isolated internal network, with no interaction with the host system’s network)

if [ $# -eq 4 ]; then
    qemu-system-x86_64 \
        -cdrom "$1" \
        -hda "$2" \
        -boot order=dc \
        -m "$3" -smp "$4" \
        -netdev user,id=net0 -device e1000,netdev=net0 \
        -enable-kvm
else
    echo help: vm-install.sh [src.iso] [dest.qcow2] [mem=2048] [cpu_num=2]
fi
