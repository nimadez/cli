#!/bin/bash

# npm depends on so many packages that it seems like too much
# so I installed the nodejs package but used wine to access npm
# of course, downloading npm packages is all I need

wine /media/$USER/local/apps/.windows/node/npm.cmd "$@"
