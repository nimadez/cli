#!/bin/bash
#
# Start a VM using qemu (optionally mount iso)
# - boot order: hdd > cdrom
# - network: SLIRP (completely isolated internal network, with no interaction with the host system’s network)
#
# to mount iso as cd-rom in debian:
#   $ sudo mkdir /media/cdrom
#   $ sudo mount /dev/sr0 /media/cdrom

if [ $# -eq 3 ]; then
    qemu-system-x86_64 \
        -hda "$1" \
        -m "$2" -smp "$3" \
        -netdev user,id=net0 -device e1000,netdev=net0 \
        -enable-kvm
elif [ $# -eq 4 ]; then
    qemu-system-x86_64 \
        -hda "$1" \
        -boot order=cd \
        -m "$2" -smp "$3" \
        -netdev user,id=net0 -device e1000,netdev=net0 \
        -cdrom "$4" \
        -enable-kvm
else
    echo help: vm-start.sh [path.qcow2] [mem=2048] [cpu_num=2] [optional disk.iso]
fi
