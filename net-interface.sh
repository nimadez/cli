#!/bin/bash
#
# Edit and update /etc/network/interfaces

ip link

read -p "press enter to edit interfaces ..." p
sudo nano /etc/network/interfaces

sudo service networking restart
