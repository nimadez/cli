# DNS Benchmark
# dig.exe required, see 'Bind 9' Windows binary package
# https://www.isc.org/bind/

import os
import sys
import subprocess


SERVERS = [
    # Google
    '8.8.8.8',
    '8.8.4.4',
    # Cloudflare
    '1.1.1.1',
    '1.0.0.1',
    # OpenDNS
    '208.67.222.222',
    '208.67.220.220',
    # UltraDNS
    '156.154.70.1',
    '156.154.71.1',
    # Shecan
    '178.22.122.100',
    '185.51.200.2',
    # Begzar
    '185.55.226.26',
    '185.55.225.25',
    # Arvan Cloud
    '185.231.182.126',
    '37.152.182.112',
    # Mobinnet
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
    os.system('color 0A')

    url = None
    if len(sys.argv) < 2:
        url = 'google.com'
    else:
        url = sys.argv[1]

    print('URL:', url)
    query = sortQuery(url)
    for i in query:
        print('%-20s %i msec'%(i[0], i[1]))

    input('Press <ENTER> to continue')
