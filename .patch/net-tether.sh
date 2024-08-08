#!/bin/bash

# quick setup USB tethering
# this doesn't work with 'network-manager-gnome'
# because gnome takes care of the network

iface=$(ip link | awk -F: '$0 !~ "enp|lo|wl|^[^0-9]"{print $2;getline}')

sudo bash -c 'cat > /etc/network/interfaces << EOF
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
EOF'
echo "allow-hotplug$iface" | sudo tee -a /etc/network/interfaces
echo "iface$iface inet dhcp" | sudo tee -a /etc/network/interfaces

read -p "press enter to restart network service ..." p
sudo service networking restart
