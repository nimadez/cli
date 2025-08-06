#!/bin/bash
#
# Windows-style blank screensaver
#
# I don't want to turn off the monitor
# xdg-screensaver activate
#
# add this line to startup script in case of suspend
# xrandr --output HDMI-0 --brightness 1

xrandr --output HDMI-0 --brightness 0
xwininfo &>/dev/null # disabled by clicking anywhere
xrandr --output HDMI-0 --brightness 1
