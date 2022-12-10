import os
import sys

#https://www.radiojavan.com/podcasts/podcast/RJ-Countdown-20210629
#http://74.115.215.45/media/podcast/mp3-192/RJ-Countdown-20210629.mp3
#https://www.radiojavan.com/mp3s/mp3/Shadmehr-Aghili-Jange-Delam
#http://74.115.215.45/media/mp3/mp3-256/Shadmehr-Aghili-Jange-Delam.mp3

if __name__== "__main__":
	if len(sys.argv) < 2:
		print('radiojavan.py <mp3/podcast url>')
		sys.exit()
	url = sys.argv[1]

	filetype = url.split('/')[3]
	filename = url.split('/')[-1] + '.mp3'

	if filetype == 'podcasts':
		os.system('aria2.bat http://74.115.215.45/media/podcast/mp3-192/' + filename)
	elif filetype == 'mp3s':
		os.system('aria2.bat http://74.115.215.45/media/mp3/mp3-256/' + filename)
