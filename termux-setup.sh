#!/bin/bash

clear

termux-setup-storage
sleep 6
ln -s storage/shared/termux shared

pkg upgrade

pkg install tor
pkg install obfs4proxy

pkg install python
pip install requests
