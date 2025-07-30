#!/usr/bin/env python3
#
# Check bitcoin balance by address

import os, sys, json, requests
from subprocess import check_output


TUNNELPROXY = f"http://{check_output(['hostname', '-I']).decode().strip()}:8118"
HEADERS = {'User-Agent':'Mozilla/5.0 (iPhone; CPU iPhone OS 13_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1 Mobile/15E148 Safari/604.1'}
BC_INVALID = '{"error":"not-found-or-invalid-arg","message":"Item not found or argument invalid"}'


def getUrl(url):
    try:
        p = { 'http': TUNNELPROXY, 'https': TUNNELPROXY }
        r = requests.get(url, proxies=p, headers=HEADERS, timeout=60)
        if r.status_code == 200:
            return r.text
        else:
            return None
    except:
        return None


if __name__== "__main__":
    if len(sys.argv) < 2:
        print('help: btc-check.py [address]')
        sys.exit()

    print('[blockchain.info]')
    test = getUrl('https://blockchain.info/q/addressbalance/' + sys.argv[1])
    if test == BC_INVALID or not test:
        print('ERROR: Invalid address or network problem.')
    else:
        received = int(getUrl('https://blockchain.info/q/getreceivedbyaddress/' + sys.argv[1]))
        sent = int(getUrl('https://blockchain.info/q/getsentbyaddress/' + sys.argv[1]))
        print("Recieved:", received / 100000000)
        print("Sent:", sent / 100000000)
        print("Balance:", (received-sent) / 100000000)
