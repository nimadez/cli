#!/usr/bin/env python3
#
# Scrap fresh proxies across the web

import os
import sys
import time
import random
import re
import signal
import requests
from subprocess import check_output


MAXRESULT = 10
USER = __import__('getpass').getuser()
BASEPATH = f'/home/{USER}/.cache/proxy-catcher'
DATABASE = BASEPATH + '/proxies.txt'
OUTPUT = BASEPATH + '/proxies_checked.txt'
TUNNELPROXY = f"{check_output(['hostname', '-I']).decode().strip()}:8118"
CHECKURL = 'http://www.google.com/humans.txt'
HEADERS = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Trident/7.0; rv:11.0) like Gecko'}


def scrapProxies(proxy):
    print('Scraping proxies from urls...')
    proxy = 'http://' + proxy
    proxies  = proxyScraper('https://raw.githubusercontent.com/TheSpeedX/PROXY-List/master/http.txt', proxy, '%ip%:%port%')
    proxies += proxyScraper('https://raw.githubusercontent.com/sunny9577/proxy-scraper/master/proxies.txt', proxy, '%ip%:%port%')
    proxies += proxyScraper('https://api.proxyscrape.com/?request=getproxies&proxytype=http&timeout=5000&country=all&ssl=all&anonymity=all', proxy, '%ip%:%port%')
    # proxies += proxyScraper('https://www.proxy-list.download/api/v1/get?type=http', proxy, '%ip%:%port%')
    # proxies += proxyScraper('https://www.us-proxy.org/', proxy, "<tr><td>%ip%<\\/td><td>%port%<\\/td><td>(.*?){2}<\\/td><td class='hm'>.*?<\\/td><td>.*?<\\/td><td class='hm'>.*?<\\/td><td class='hx'>(.*?)<\\/td><td class='hm'>.*?<\\/td><\\/tr>")
    # proxies += proxyScraper('https://free-proxy-list.net/', proxy, "<tr><td>%ip%<\\/td><td>%port%<\\/td><td>(.*?){2}<\\/td><td class='hm'>.*?<\\/td><td>.*?<\\/td><td class='hm'>.*?<\\/td><td class='hx'>(.*?)<\\/td><td class='hm'>.*?<\\/td><\\/tr>")
    # proxies += proxyScraper('https://www.sslproxies.org/', proxy, "<tr><td>%ip%<\\/td><td>%port%<\\/td><td>(.*?){2}<\\/td><td class='hm'>.*?<\\/td><td>.*?<\\/td><td class='hm'>.*?<\\/td><td class='hx'>(.*?)<\\/td><td class='hm'>.*?<\\/td><\\/tr>")
    # proxies += proxyScraper('http://spys.me/proxy.txt', proxy, '%ip%:%port%')
    # proxies += proxyScraper('http://www.httptunnel.ge/ProxyListForFree.aspx', proxy, " target=\"_new\">%ip%:%port%</a>")
    unique = list(set(proxies)) 	# remove duplicates
    random.shuffle(unique) 		    # randomize again
    print('Total:', len(proxies))
    print('Unique:', len(unique))
    return unique


def proxyScraper(url, proxy, regex):
    proxies = []
    content = getUrl(url, proxy)
    if content == None:
        print(' => (0)')
        return proxies
    regex = regex.replace('%ip%', '([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3})')
    regex = regex.replace('%port%', '([0-9]{1,5})')
    for p in re.findall(re.compile(regex), content):
        proxies.append(p[0] + ":" + p[1])
    print(' => (' + str(len(proxies)) + ')')
    return proxies

    
def checkProxies(proxyList, port, ignored):
    if len(proxyList) > 0:
        open(OUTPUT, 'w').close() # clear output file
        random.shuffle(proxyList)
        print('Checking proxies...')
        count = 0
        for proxy in proxyList:
            if port == None: 				  		# check for all ports
                if proxy.split(':')[1] != ignored: 	# ignored port
                    if checkProxy(proxy):
                        count += 1
            elif port == proxy.split(':')[1]: 	# check for specific port
                if checkProxy(proxy):
                    count += 1
            if count == MAXRESULT:
                break
    else:
        print('Unable to read database.')


def checkProxy(proxy):
    try:
        p = { 'http': 'http://' + proxy, 'https': 'http://' + proxy }
        sys.stdout.write("\r checking [%s]      " %proxy)
        sys.stdout.flush()
        start = time.time()
        r = requests.get(CHECKURL, proxies=p, headers=HEADERS, timeout=2, allow_redirects=True)
        if r.status_code == 200 and 'Google is built' in r.text:
            end = round(time.time()-start, 2)
            sys.stdout.write("\r OK %sms %s      \n" %(str(end), proxy))
            sys.stdout.flush()
            writeProxy(proxy, OUTPUT)
            return True
        return False
    except KeyboardInterrupt: # CTRL+C signal KeyboardInterrupt
        signal.signal(signal.SIGINT, signalHandler)
        showProxies()
        sys.exit()
    except:
        return False


def signalHandler(signal, frame): 
    None


def getUrl(url, proxy):
    try:
        p = { 'http': proxy, 'https': proxy }
        r = requests.get(url, proxies=p, headers=HEADERS, timeout=20)
        if r.status_code == 200:
            print('GET ::', url[:50], end='') # end= behave like \n after sys.stdout.write in checkProxy()
            return r.text
        else:
            print('ERR ::', url[:50], end='')
            return None
    except:
        print('ERR ::', url[:50], end='')
        return None


def readProxies(path):
    proxies = []
    if os.path.isfile(path):
        with open(path, "r") as f:
            proxies = f.read().splitlines()
    return proxies


def writeProxies(proxies, path):
    open(path, 'w').close()
    for proxy in proxies:
        with open(path, "a") as f:
            f.write(proxy + '\n')


def writeProxy(proxy, path):
    with open(path, "a") as f:
        f.write(proxy + '\n')


def showProxies():
    print('\n')
    for i in readProxies(OUTPUT):
        print('| ' + i)


if __name__== "__main__":
    if not os.path.exists(BASEPATH):
        os.makedirs(BASEPATH)
        
    opt = input('Update Database (y/n)? ')
    if opt == 'y' or opt == 'Y':
        proxy = input('Tunnel Proxy (default=' + TUNNELPROXY + ')> ')
        if not proxy:
            proxy = TUNNELPROXY
        proxyList = scrapProxies(proxy)
        if len(proxyList) > 0:
            writeProxies(proxyList, DATABASE)

    opt = input('Check Specific Port (y/n)? ')
    if opt == 'y' or opt == 'Y':
        port = input('Port (default=3128)> ')
        if not port:
            port = '3128'
        checkProxies(readProxies(DATABASE), port, None)
    else:
        ignored = input('Ignored Port (default=80)> ')
        if not ignored:
            ignored = '80'
        checkProxies(readProxies(DATABASE), None, ignored)

    showProxies()
    input('Press enter to continue ...')
