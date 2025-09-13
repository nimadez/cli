#!/bin/bash
#
# Play audio and video using vlc in terminal with curses interface

if [ $# -eq 1 ]; then
    cvlc -I ncurses "$1"
else
    echo "Usage: play-vlc.sh [path, url, .xspf]"
fi
