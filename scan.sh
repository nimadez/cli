#!/bin/bash
#
# Uses ClamAV antivirus to scan a file or directory (recursive)

if [ $# -eq 1 ]; then

    if [ ! -r "$1" ]; then
        echo "File or directory not found."
        exit 1
    fi
    
    # check for database updates
    sudo freshclam

    if [ -f "$1" ]; then
        clamscan "$1"
    elif [ -d "$1" ]; then
        clamscan -r "$1"
    fi
else
    echo "Usage: scan.sh [file/directory]"
fi
