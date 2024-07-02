#!/bin/bash

# start vlc with terminal user-interface

if [ $# -eq 1 ]; then
    cvlc -I ncurses "$1"
else
    echo help: vlc.sh [uri/playlist/.xspf]
fi
