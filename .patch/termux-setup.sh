#!/bin/bash
#
# Initialize and setup Termux

termux-setup-storage
sleep 8
ln -s storage/shared/termux shared

pkg upgrade
pkg install git curl aria2 nano openssh
pkg install python

ssh-keygen -t rsa -b 4096
