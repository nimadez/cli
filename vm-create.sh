#!/bin/bash
#
# Create a VM from ISO using qemu
# - boot order: cdrom > hdd
# - optional network: SLIRP (isolated internal network)

if [ $# -gt 1 ]; then
    hdd="10G"
    cpu="2"
    mem="2048"
    net="on"

    if [ "$3" ]; then
        hdd="$3"
    fi

    if [ "$4" ]; then
        cpu="$4"
    fi

    if [ "$5" ]; then
        mem="$5"
    fi

    if [ "$6" ]; then
        net="$6"
    fi

    qemu-img create -f qcow2 "$2" "$hdd"

    if [ "$net" = "on" ]; then
        qemu-system-x86_64 \
            -cdrom "$1" \
            -hda "$2" \
            -boot order=dc \
            -smp "$cpu" -m "$mem" \
            -netdev user,id=net0 -device e1000,netdev=net0 \
            -enable-kvm
    else
        qemu-system-x86_64 \
            -cdrom "$1" \
            -hda "$2" \
            -boot order=dc \
            -smp "$cpu" -m "$mem" \
            -enable-kvm
    fi
else
    echo "Usage: vm-create.sh [src.iso] [dest.qcow2] [? hdd=10G] [? cpu=2] [? mem=2048] [? net=on]"
fi
