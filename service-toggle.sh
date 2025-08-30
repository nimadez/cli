#!/bin/bash
#
# Toggle a service enable/disable

if [ $# -eq 1 ]; then
    if [ "$(systemctl is-active "$1")" = "active" ]; then
        sudo systemctl stop "$1"
        sudo systemctl disable "$1"
    else
        sudo systemctl enable "$1"
        sudo systemctl restart "$1"
    fi
else
    echo "Usage: service-toggle.sh [service]"
fi
