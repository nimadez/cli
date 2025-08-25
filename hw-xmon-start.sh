#!/bin/bash
#
# XMon Autostart
# - It should appear in the bottom-right corner
# - Let it finish so that "Always on Top" is set up properly

R=$(xrandr | grep '*' | awk '{print $1}')
W=$(echo "$R" | cut -d 'x' -f1)
H=$(echo "$R" | cut -d 'x' -f2)

xterm -fa "Droid Sans Mono" -fs 9 -geometry 28x4+$W+$H -bg Grey14 -T "XMon" -e hw-xmon &
