#!/bin/bash

# debug kernel messages (may appear on boot)

sudo dmesg --level=err
read -p "press enter to show all messages ..." p
sudo dmesg
