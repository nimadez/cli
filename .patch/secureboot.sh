#!/bin/bash
#
# Disable or re-enable the secureboot

mokutil --sb-state

read -p "enter enable/disable: " sb
if [ "$sb" = "enable" ]; then
    sudo mokutil --enable-validation
elif [ "$sb" = "disable" ]; then
    sudo mokutil --disable-validation
fi
