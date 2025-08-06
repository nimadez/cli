#!/bin/bash
#
# A quick tcpdump network traffic monitor

sudo tcpdump -D
read -p "Interface: " i
sudo tcpdump -Q inout -i $i
