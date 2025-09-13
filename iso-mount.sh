#!/bin/bash
#
# Mount/unmount iso as CD-ROM

PATH="/media/$USER/CDROM"

if [ $# -eq 1 ]; then
    if [ -d "$PATH" ]; then
        sudo umount "$PATH"
        sudo rm -rf "$PATH"
    else
        if [ -f "$1" ]; then
            sudo mkdir "$PATH" 2>/dev/null
            sudo mount "$1" "$PATH"
        else
            echo "File [$1] does not exist."
        fi
    fi
else
    echo "Usage: iso-mount.sh [iso]"
fi
