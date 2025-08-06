#!/bin/bash
#
# Call the scripts from wherever you are

scr=$(realpath "$0")
dir=$(dirname "$scr")

for i in *.sh; do
    if [ "$i" != "install.sh" ]; then
        sudo rm "/usr/local/bin/${i%%.sh}" 2>/dev/null
        ln -s "$dir/$i" "/usr/local/bin/${i%%.sh}"
    fi
done

for i in *.py; do
    sudo rm "/usr/local/bin/${i%%.py}" 2>/dev/null
    ln -s "$dir/$i" "/usr/local/bin/${i%%.py}"
done

for i in *.js; do
    sudo rm "/usr/local/bin/${i%%.js}" 2>/dev/null
    ln -s "$dir/$i" "/usr/local/bin/${i%%.js}"
done

sudo chmod +x /usr/local/bin/*
sudo chown -R $(whoami) /usr/local/bin
echo Done
