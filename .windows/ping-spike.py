import sys
import os
import subprocess
import re 
import platform

MAX = '10'

if len(sys.argv) < 2:
    print('ping-spike.py <hostname>')
    sys.exit()
if platform.system() != 'Windows':
    print('exit: for windows only.')
    sys.exit()

host = sys.argv[1]

print('Checking Server [%s] ...'%(host))
response = os.system('ping -n 1 %s >nul 2>&1'%(host))
if response != 0:
    print('Failed: Unreachable Server')
    sys.exit()

print('Processing...')
output = subprocess.check_output(['ping', '-n', MAX, host], shell=True, text=True)
data = re.findall(r'time=\d+', output)
times = []

for i in data:
    time = int(i.replace('time=', ''))
    times.append(time)
    print(str(time).ljust(4), end='')
    for i in range(int(time / 3)):
        print('|', end='')
    print('')

maxTime = max(times)
minTime = min(times)
difTime = maxTime - minTime
print('Max:', maxTime, '| Min:', minTime, '| Dif:', difTime)
