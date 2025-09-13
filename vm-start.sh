#!/bin/bash
#
# Start a VM using qemu
# - boot order: hdd > cdrom (optional iso mount)
# - optional network: SLIRP (isolated internal network)
# - supports SSH access from host to guest (user@10.0.2.15 in DHCP mode)

if [ $# -gt 0 ]; then
    CPU="2"
    MEM="2048"
    NET="on"
    ISO=""

    if [ "$2" ]; then
        CPU="$2"
    fi

    if [ "$3" ]; then
        MEM="$3"
    fi

    if [ "$4" ]; then
        NET="$4"
    fi

    if [ "$5" ]; then
        ISO="$5"
    fi

    if [ "$NET" = "on" ]; then
        qemu-system-x86_64 \
            -hda "$1" \
            -cdrom "$5" \
            -boot order=cd \
            -smp "$CPU" -m "$MEM" \
            -netdev user,id=net0,hostfwd=tcp::5555-:22 \
            -device e1000,netdev=net0 \
            -vga qxl \
            -enable-kvm
    else
        qemu-system-x86_64 \
            -hda "$1" \
            -cdrom "$5" \
            -boot order=cd \
            -smp "$CPU" -m "$MEM" \
            -nic none \
            -vga qxl \
            -enable-kvm
    fi
else
    echo "Usage: vm-start.sh [path.qcow2] [? cpu=2] [? mem=2048] [? net=on] [? cdrom.iso]"
fi
