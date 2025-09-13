#!/bin/bash
#
# XMon Autostart
#
# - It should appear in the bottom-left corner of the screen
# - Automatic "Always on Top" and "Always on Visible Workspace"
#
# $ sudo apt install xterm wmctrl
#
# Add to startup:
# $ echo "cli hw-xmon-start" >> ~/.config/autostart/startup.sh

DIR=$(dirname $(realpath "$0"))
R=$(xrandr | grep '*' | awk '{print $1}')
W=$(echo "$R" | cut -d 'x' -f1)
H=$(echo "$R" | cut -d 'x' -f2)

xterm -fa "Monospace" -fs 9 -geometry 28x4+0+$H -bg Grey14 -T "XMon" -e "$DIR/hw-xmon" &
sleep 2
wmctrl -Fa "XMon" -b add,above,sticky
