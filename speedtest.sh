#!/bin/bash
#
# Get and run speedtest-cli

echo Downloading speedtest.py...
curl -s --ssl-no-revoke -o ~/.cache/speedtest.py https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py

python3 ~/.cache/speedtest.py --single --secure --no-pre-allocate
