#!/bin/bash

if [ $# -eq 1 ]; then
    hexdump -C "$1"
else
    echo help: hex-dump.sh [file]
fi
