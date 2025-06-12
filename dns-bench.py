#!/usr/bin/env python3
#
# Benchmark DNS servers

import os
import sys
import subprocess


SERVERS = [
    '8.8.8.8',
    '8.8.4.4',
    '1.1.1.1',
    '1.0.0.1',
    '208.67.222.222',
    '208.67.220.220',
    '156.154.70.1',
    '156.154.71.1',
    '178.22.122.100',
    '185.51.200.2',
    '185.55.226.26',
    '185.55.225.25',
    '185.231.182.126',
    '37.152.182.112',
    '10.104.88.8',
    '10.104.88.9'
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
