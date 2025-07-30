#!/bin/bash
#
# Find gateway ip address

ip route
echo -------------
ip link
read -p "DEVICE: " dev
ip route show 0.0.0.0/0 dev "$dev" | cut -d\  -f3
