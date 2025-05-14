#!/bin/bash
#
# Start vlc in terminal with curses interface

if [ $# -eq 1 ]; then
    cvlc -I ncurses "$1"
else
    echo help: vlcc.sh [path/url/.xspf]
fi
