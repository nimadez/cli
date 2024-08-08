#!/bin/bash

# to call the scripts from wherever you are

scr=$(realpath "$0")
dir=$(dirname "$scr")

for i in *.sh; do
    sudo rm "/usr/local/bin/${i%%.sh}"
    ln -s "$dir/$i" "/usr/local/bin/${i%%.sh}"
done

for i in *.py; do
    sudo rm "/usr/local/bin/${i%%.py}"
    ln -s "$dir/$i" "/usr/local/bin/${i%%.py}"
done

for i in *.js; do
    sudo rm "/usr/local/bin/${i%%.js}"
    ln -s "$dir/$i" "/usr/local/bin/${i%%.js}"
done

sudo rm /usr/local/bin/install

sudo chmod +x /usr/local/bin/*
sudo chown -R $(whoami) /usr/local/bin
echo Done
