#!/bin/bash
#
# Run a command without internet access
#
# preserve current iptables
# no changes in the current terminal
# run command, bash, binary, python

if [ $# -eq 1 ]; then
    sudo addgroup no-internet 2>/dev/null
    
    sudo iptables-save > ~/.cache/iptables.rules.bkp
    sudo iptables --flush
    sudo iptables -A OUTPUT -m owner --gid-owner no-internet -j DROP
    sudo -g no-internet sh -c "$1"
    sudo iptables-restore < ~/.cache/iptables.rules.bkp

    rm ~/.cache/iptables.rules.bkp
else
    echo help: net-block.sh [command/path]
fi
