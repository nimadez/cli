#!/bin/bash

# A windows-style blank screensaver

# we don't want to turn off the monitor
#xdg-screensaver activate

# not sure if this change is permanent,
# if suspended, add this line to startup:
# xrandr --output HDMI-0 --brightness 1

xrandr --output HDMI-0 --brightness 0
read -p "..." x
xrandr --output HDMI-0 --brightness 1
