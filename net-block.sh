#!/bin/bash
#
# Run a command without internet access (new version)
#
# Prerequisite (e.g. add to startup script):
# $ sudo addgroup no-internet
# $ sudo iptables -A OUTPUT -m owner --gid-owner no-internet -j DROP
#
# There is a way to save and restore iptables,
# but it won't work if the process is downloading in the background.
# $ sudo iptables-save > ~/.cache/iptables.rules.bkp
# $ sudo iptables -A OUTPUT -m owner --gid-owner no-internet -j DROP
# $ sudo iptables-restore < ~/.cache/iptables.rules.bkp

if [ $# -gt 1 ]; then
    sudo -g no-internet "$@"
else
    echo help: net-block.sh [command/path]
fi
