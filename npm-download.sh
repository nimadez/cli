#!/bin/bash

if [ $# -eq 1 ]; then
    wine /media/$USER/local/apps/.windows/node/npm.cmd pack $1
else
    echo help: npm-download.sh [module-name]
fi
