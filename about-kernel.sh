#!/bin/bash
#
# Debug kernel messages

hostnamectl
echo
sudo dmesg --level=err
read -p "press enter to show all messages ..." p
sudo dmesg
