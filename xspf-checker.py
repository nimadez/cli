#!/usr/bin/env python3
#
# Check xspf playlist for broken links

import os, sys, requests
from xml.dom import minidom
from urllib3.exceptions import InsecureRequestWarning
requests.packages.urllib3.disable_warnings(category=InsecureRequestWarning)


def getChildren(node, key):
    for child in node.childNodes:
        if child.localName == key:
            yield child


def readPlaylist(path):
    playlist = []
    if os.path.isfile(path):
        dom = minidom.parse(path)
        tracks = dom.getElementsByTagName('track')
        for node in tracks:
            titles = []
            locations = []
            for t in getChildren(node, 'title'):
                titles.append(t.childNodes[0].nodeValue)
            for l in getChildren(node, 'location'):
                locations.append(l.childNodes[0].nodeValue)
            for i in range(len(titles)):
                playlist.append([ titles[i], locations[i] ])
    else:
        print('file not found.')
        sys.exit()
    return playlist


def getURL(url):
    HEADERS = {'User-Agent':'VLC/3.0.12 LibVLC/3.0.12'}
    try:
        r = requests.get(url, headers=HEADERS, timeout=20, allow_redirects=True, stream=True, verify=False)
        if r.status_code == requests.codes.ok:
            return True
        else:
            return False
    except:
        return False


def check(playlist):
    for item in playlist:
        result = getURL(item[1])
        if result:
            print('OK  ::', item[0], '-', item[1][:50])
        else:
            print('ERR ::', item[0], '-', item[1][:50])


if __name__== "__main__":
    if len(sys.argv) < 2:
        print('help: xspf-checker.py [path]')
        sys.exit()
    path = sys.argv[1]
    print('checking...')
    check(readPlaylist(path))
