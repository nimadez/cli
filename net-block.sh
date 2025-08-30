#!/bin/bash
#
# Run a command without internet access
#
# Prerequisite:
# $ sudo addgroup no-internet
# $ sudo iptables -A OUTPUT -m owner --gid-owner no-internet -j DROP
# (see docs/iptables.md)
#
# $ net-block curl https://google.com (Could not resolve host: google.com)
# $ net-block $command (permission denied)
# $ net-block sudo $command (re-enter password)

GID=$(getent group no-internet | awk -F: '{print $3}')
ACCEPT="\-A OUTPUT -m owner --gid-owner $GID -j ACCEPT"
DROP="\-A OUTPUT -m owner --gid-owner $GID -j DROP"

if [ $# -eq 0 ]; then
    echo "Usage: net-block.sh [command]"
    exit 0
fi

# a rule exist, but is ACCEPT
if [[ $(sudo iptables -S | grep "$ACCEPT") != "" ]]; then
    echo "Unable to execute the command, found [ACCEPT no-internet] rule in iptables."
    exit 1
fi

# a DROP rule is not available
if [[ $(sudo iptables -S | grep "$DROP") = "" ]]; then
    echo "Unable to execute the command, cannot find [DROP no-internet] rule in iptables."
    exit 1
fi

sudo -g no-internet "$@"
