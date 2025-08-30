#!/bin/bash
#
# Mount/unmount iso as CD-ROM

path="/media/$USER/CDROM"

if [ $# -eq 1 ]; then
    if [ -d "$path" ]; then
        sudo umount "$path"
        sudo rm -rf "$path"
    else
        if [ -f "$1" ]; then
            sudo mkdir "$path" 2>/dev/null
            sudo mount "$1" "$path"
        else
            echo "File [$1] does not exist."
        fi
    fi
else
    echo "Usage: iso-mount.sh [iso]"
fi
