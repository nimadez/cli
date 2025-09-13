#!/bin/bash
#
# Download npm package without npm!
#
# npm depends on so many packages that it seems like too much
# so I installed the nodejs package but used this to download
# packages. Of course, downloading npm packages is all I need.
#
# $ npm-get three 0.168.0

if [ $# -eq 2 ]; then
    wget "$(curl https://registry.npmjs.org/$1/$2 | grep -o '"tarball":"[^"]*"' | sed 's/"tarball":"\(.*\)"/\1/')"
else
    echo "Usage: npm-get.sh [package] [version]"
fi
