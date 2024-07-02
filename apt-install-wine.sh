#!/bin/bash

# wine in the trixie/testing branch
# runs more windows programs with fewer errors.

sudo apt -y install wine

read -p "add i386 architecture and install wine32 (y)? " p
if [ "$p" = "y" ]; then
    sudo dpkg --add-architecture i386
    sudo apt update
    sudo apt -y install wine32:i386
fi
