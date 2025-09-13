#!/bin/bash
#
# Get basic information about the system

hostnamectl
echo

read -p "press enter to continue ..." p ;echo
lsblk
echo
df -h

read -p "press enter to continue ..." p ;echo
ip link

if nvidia-smi >/dev/null; then
    echo
    read -p "press enter to continue ..." p ;echo
    nvidia-smi
fi

read -p "press enter to continue ..." p ;echo
top
