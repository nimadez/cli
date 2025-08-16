#!/bin/bash
#
# Run a command without internet access
#
# Prerequisite (add to startup script):
# $ sudo addgroup no-internet
# $ sudo iptables -A OUTPUT -m owner --gid-owner no-internet -j DROP

if [ $# -gt 1 ]; then
    sudo -g no-internet "$@"
else
    echo "help: net-block.sh [command/path]"
fi
