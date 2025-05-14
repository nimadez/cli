#!/bin/bash
#
# Initialize and setup Termux

termux-setup-storage
sleep 8
ln -s storage/shared/Termux shared

read -p "press enter to upgrade and install packages ..." p
pkg upgrade
pkg install git curl aria2 nano openssh
pkg install python

read -p "press enter to generate SSH key ..." p
ssh-keygen -t rsa -b 4096
