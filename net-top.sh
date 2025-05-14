#!/bin/bash
#
# A quick iftop network traffic monitor

ip link
read -p "Interface name: " i
sudo iftop -p -P -i $i
