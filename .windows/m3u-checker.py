import os
import sys
import requests
from urllib3.exceptions import InsecureRequestWarning
requests.packages.urllib3.disable_warnings(category=InsecureRequestWarning)


def readPlaylist(path):
	data = []
	playlist = []
	title = ""
	if os.path.isfile(path):
		with open(path, "r", encoding='utf_8') as f:
			data = f.read().splitlines()
		for line in data:
			if '#EXTINF' in line:
				title = line.split(',')[1]
			if '#' not in line and line.startswith('http'):
				playlist.append([title, line])
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
		print('m3u-checker.py <path-to-m3u>')
		sys.exit()
	path = sys.argv[1]
	print('checking...')
	check(readPlaylist(path))
