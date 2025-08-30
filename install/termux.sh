#!/bin/bash
#
# Setup Termux
#
# $ termux-setup-storage
# $ sh ~/storage/shared/Download/termux.sh

pkg upgrade
pkg install -y git curl nano openssh
pkg autoclean
pkg clean

mkdir ~/storage/shared/termux
ln -s ~/storage/shared/termux ~/shared

cd ~/shared
rm -rf ./cli
git clone https://github.com/nimadez/cli

ssh-keygen -t rsa -b 4096
> /data/data/com.termux/files/home/.ssh/known_hosts

echo "done"
