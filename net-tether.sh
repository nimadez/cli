#!/bin/bash
#
# Quick setup USB Tethering interface
#
# Notice: This is only used for post-installation, because we rely on network-manager.

IFACE=$(ls /sys/class/net | grep ^enx)

if [ "$IFACE" ]; then
    sudo tee /etc/network/interfaces << EOF
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug $IFACE
iface $IFACE inet dhcp
EOF

    sudo systemctl restart networking
else
    echo "Enable USB tethering on your mobile device."
fi
