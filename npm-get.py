#!/usr/bin/env python3
#
# Download npm package without npm!
#
# npm depends on so many packages that it seems like too much
# so I installed the nodejs package but used this to download
# packages. Of course, downloading npm packages is all I need.
#
# $ npm-get three 0.168.0

import os, sys, json, requests


def get(p, v):
    r = requests.get(f'https://registry.npmjs.org/{p}/{v}', headers = { "Content-Type": "application/json" })
    r.raise_for_status()
    print(r.json()["dist"]["tarball"])
    return r.json()["dist"]["tarball"]


if __name__ == "__main__":
    if len(sys.argv) > 2:
        os.system(f'wget -nH --cut-dirs -r --tries=10 {get(sys.argv[1], sys.argv[2])}')
    else:
        print("help: python3 npm-get.py [package] [version]")
