#!/bin/bash
#
# Disable or re-enable the secureboot

mokutil --sb-state

read -p "Enter enable/disable: " p
if [ "$p" = "enable" ]; then
    sudo mokutil --enable-validation
elif [ "$p" = "disable" ]; then
    sudo mokutil --disable-validation
fi
