#!/bin/bash
#
# Get basic information about the system

hostnamectl
read -p "press enter to continue ..." p
echo; lsblk
echo; df -h
read -p "press enter to continue ..." p
echo; ip link
read -p "press enter to continue ..." p
echo; nvidia-smi
read -p "press enter to continue ..." p
top
