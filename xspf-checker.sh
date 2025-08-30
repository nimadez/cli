#!/bin/bash
#
# Check xspf playlist for broken links

if [ $# -eq 1 ]; then
    grep -oP "(?<=<location>)(.*?)(?=</location>)" "$1" | while read url; do

        code=$(curl --max-time 10 --head --silent --output /dev/null --write-out '%{http_code}' "$url")

        res="  "
        if [ $code -eq 200 ]; then
            res="OK"
        fi
        
        echo "$code $res | $url"
    done
else
    echo "Usage: xspf-checker.sh [xspf]"
fi
