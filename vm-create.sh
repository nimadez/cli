#!/bin/bash
#
# Create a VM from ISO using qemu
# - boot order: cdrom > hdd
# - optional network: SLIRP (isolated internal network)

if [ $# -gt 1 ]; then
    HDD="10G"
    CPU="2"
    MEM="2048"
    NET="on"

    if [ "$3" ]; then
        HDD="$3"
    fi

    if [ "$4" ]; then
        CPU="$4"
    fi

    if [ "$5" ]; then
        MEM="$5"
    fi

    if [ "$6" ]; then
        NET="$6"
    fi

    qemu-img create -f qcow2 "$2" "$HDD"

    if [ "$NET" = "on" ]; then
        qemu-system-x86_64 \
            -cdrom "$1" \
            -hda "$2" \
            -boot order=dc \
            -smp "$CPU" -m "$MEM" \
            -netdev user,id=net0 \
            -device e1000,netdev=net0 \
            -vga qxl \
            -enable-kvm
    else
        qemu-system-x86_64 \
            -cdrom "$1" \
            -hda "$2" \
            -boot order=dc \
            -smp "$CPU" -m "$MEM" \
            -nic none \
            -vga qxl \
            -enable-kvm
    fi
else
    echo "Usage: vm-create.sh [src.iso] [dest.qcow2] [? hdd=10G] [? cpu=2] [? mem=2048] [? net=on]"
fi
