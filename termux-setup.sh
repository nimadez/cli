#!/bin/bash
clear

termux-setup-storage
sleep 6
ln -s storage/shared/termux shared

pkg upgrade

pkg install git
pkg install python
