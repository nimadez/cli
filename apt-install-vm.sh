#!/bin/bash
#
# Install qemu and libvirt

sudo apt -y install --no-install-recommends qemu-system qemu-system-gui qemu-utils libvirt-clients libvirt-daemon-system

sudo adduser $(whoami) libvirt
