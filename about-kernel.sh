#!/bin/bash
#
# Get the kernel log and check for possible errors

hostnamectl
echo
sudo dmesg --level=err
read -p "press enter to show all messages ..." p
sudo dmesg | less -M -X
