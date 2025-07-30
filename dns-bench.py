#!/usr/bin/env python3
#
# Benchmark DNS servers

import os, sys, subprocess


SERVERS = [
    '8.8.8.8',
    '8.8.4.4',
    '1.1.1.1',
    '1.0.0.1',
    '208.67.222.222',   # OpenDNS
    '208.67.220.220',
    '156.154.70.1',     # UltraDNS
    '156.154.71.1'
]


def sortByQueryTime(item):
    return item[1]


def sortQuery(url):
    sorted = []
    for i in SERVERS:
        output = subprocess.check_output(['dig', i, url], shell=True, text=True)
        sorted.append( [i, output.rfind("Query time:")] )
    sorted.sort(key=sortByQueryTime)
    return sorted


if __name__== "__main__":
    url = None
    if len(sys.argv) < 2:
        url = 'google.com'
    else:
        url = sys.argv[1]

    print('URL:', url)
    query = sortQuery(url)
    for i in query:
        print('%-20s %i ms'%(i[0], i[1]))
