#!/bin/bash
#
# Install qemu and libvirt virtual-machine emulator

sudo apt install --no-install-recommends \
    qemu-system qemu-system-gui qemu-utils \
    libvirt-clients libvirt-daemon-system

# setup libvirt
sudo adduser $(whoami) libvirt

echo "done"
