#!/bin/bash
#
# Start vlc in terminal with curses interface

if [ $# -eq 1 ]; then
    cvlc -I ncurses "$1"
else
    echo help: vlcc.sh [path, url, .xspf playlist]

    read -p "press enter to play radio stream ..." p
    cvlc -I ncurses https://kathy.torontocast.com:1825/stream
fi
