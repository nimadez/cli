#!/bin/bash

# npm depends on so many packages that it seems like too much
# so I installed the nodejs package but used wine to access npm
# of course, downloading npm packages is all I need

if [ $# -eq 1 ]; then
    wine /media/$USER/local/apps/.windows/node/npm.cmd pack $1
else
    echo help: npm-download.sh [module-name]
fi
