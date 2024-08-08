#!/bin/bash

if [ $# -eq 1 ]; then
    exiftool -All= "$1"
else
    echo help: meta-rm.sh [path]
fi
