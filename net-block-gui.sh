#!/bin/bash
#
# Run a GUI-based application without internet access
#
# Notice: This is suitable for running applications outside of the terminal,
# if you are running a command/app from the terminal, use "net-block.sh" script.
#
# Prerequisite:
# $ sudo addgroup no-internet
# $ sudo iptables -A OUTPUT -m owner --gid-owner no-internet -j DROP
# $ sudo apt install zenity
# (see docs/iptables.md)
#
# $ net-block-gui /path-to/application

GID=$(getent group no-internet | awk -F: '{print $3}')
ACCEPT="\-A OUTPUT -m owner --gid-owner $GID -j ACCEPT"
DROP="\-A OUTPUT -m owner --gid-owner $GID -j DROP"

P=$(zenity --password --title="[sudo] Net Block")
if [ ! "$P" ]; then
    exit 0
fi

if ! echo "$P" | sudo -k -S true; then
    zenity --error --text="[sudo] Incorrect Password"
    exit 1
fi

if echo "$P" | sudo -k -S iptables -S | grep "$ACCEPT" >/dev/null; then
    zenity --error --text="Invalid rule: [ACCEPT no-internet]"
    exit 1
fi

if ! echo "$P" | sudo -k -S iptables -S | grep "$DROP" >/dev/null; then
    zenity --error --text="Missing rule: [DROP no-internet]"
    exit 1
fi

echo "$P" | sudo -k -S -g no-internet "$@" &
