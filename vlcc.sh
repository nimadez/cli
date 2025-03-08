#!/bin/bash
#
# Start vlc in terminal with curses interface

if [ $# -eq 1 ]; then
    cvlc -I ncurses "$1"
else
    echo help: vlcc.sh [path, url, .xspf playlist]

    read -p "press enter to play radio stream ..." p
    cvlc -I ncurses https://streamssl.chilltrax.com:80/stream/1/
fi
