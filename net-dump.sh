#!/bin/bash
#
# A quick tcpdump network traffic monitor
# (optionally, limited to new dropped TCP connections, exclude ssh port 22)

sudo tcpdump -D

read -p "Interface: " i
read -p "Filter dropped connections (Y/y): " drop

if [ "$drop" = "y" -o "$drop" = "Y" ]; then
    sudo tcpdump -n -i "$i" 'tcp[tcpflags] & (tcp-syn) != 0 and not dst port 22'
else
    sudo tcpdump -Q inout -n -i "$i"
fi
