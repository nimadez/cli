#!/bin/bash
#
# Edit and update /etc/network/interfaces
# network-manager-gnome takes care of the network
# but we still need this for some networking configurations

ip link
read -p "press enter to continue ..." p
sudo nano /etc/network/interfaces
sudo service networking restart
