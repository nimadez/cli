#!/bin/bash
#
# Toggle a service enable/disable

if [ $# -eq 1 ]; then
    status=$(systemctl is-active "$1")
    if [ "$status" = "active" ]; then
        sudo systemctl stop "$1"
        sudo systemctl disable "$1"
    else
        sudo systemctl enable "$1"
        sudo systemctl restart "$1"
    fi
else
    echo help: service-toggle.sh [service-name]
fi
