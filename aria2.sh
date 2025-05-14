#!/bin/bash
#
# Aria2c downloader with built-in config file

cat > ~/.cache/aria2c.conf <<EOF
dir=/home/$USER/Downloads
log-level=notice
check-certificate=false
disable-ipv6=true
file-allocation=none
proxy-method=get
connect-timeout=120
http-no-cache=true
disk-cache=0

continue=true
allow-overwrite=false
max-overall-download-limit=0
max-overall-upload-limit=0
max-concurrent-downloads=1
min-split-size=20M
max-connection-per-server=16
split=16

seed-time=0
enable-peer-exchange=true
bt-save-metadata=true
bt-hash-check-seed=true
bt-remove-unselected-file=true

enable-rpc=false
rpc-listen-port=6800
rpc-allow-origin-all=true
rpc-listen-all=true
rpc-save-upload-metadata=true
rpc-secure=false
EOF

if [ $# -eq 1 ]; then
    aria2c --conf-path=/home/$USER/.cache/aria2c.conf "$1"
else
    echo help: aria2.sh [link/magnet/.torrent]
fi

rm ~/.cache/aria2c.conf
