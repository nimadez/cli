#!/bin/bash
#
# Quick setup USB tethering interface
# this doesn't work with 'network-manager-gnome'
# because gnome takes care of the network

iface=$(ls /sys/class/net | egrep -i ^enx)

sudo bash -c 'cat > /etc/network/interfaces << EOF
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
EOF'
echo "allow-hotplug $iface" | sudo tee -a /etc/network/interfaces
echo "iface $iface inet dhcp" | sudo tee -a /etc/network/interfaces

read -p "press enter to restart network service ..." p
sudo service networking restart
