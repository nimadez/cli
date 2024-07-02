#!/bin/bash

# to call the scripts from wherever you are

scr=$(realpath "$0")
dir=$(dirname "$scr")

sudo cp $dir/*.sh /usr/local/bin/
sudo cp $dir/*.py /usr/local/bin/
sudo cp $dir/electron /usr/local/bin/

sudo chmod +x /usr/local/bin/*.sh
sudo chmod +x /usr/local/bin/*.py
sudo chmod +x /usr/local/bin/electron

echo Done
