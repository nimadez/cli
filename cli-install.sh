#!/bin/bash
#
# Call the scripts from wherever you are
# 
# 1. Install: This will symlink scripts to /usr/local/bin, remove extensions, and add execute permissions.
# 2. Uninstall: This will remove symlinks from /usr/local/bin, and remove execute permissions.
# x. Wipe: This will remove all files from /usr/local/bin

echo "  FORK ME https//github.com/nimadez/cli"
echo "   ______    __        __              "
echo "  /\  ___\  /\ \      /\ \    X LINUX X"
echo "  \ \ \____ \ \ \____ \ \ \   DEBIAN OS"
echo "   \ \_____\ \ \_____\ \ \_\  ASSISTANT"
echo "    \/_____/  \/_____/  \/_/  @ nimadez"
echo
echo "  1. Install"
echo "  2. Uninstall"
echo "  x. Wipe /usr/local/bin/*"
read -p "  :  " p
echo;sudo -p "  Password: " chown -R $(whoami) /usr/local/bin

if [ "$p" = "x" ]; then
    total=$(ls /usr/local/bin/ | wc -l)
    sudo rm /usr/local/bin/* 2>/dev/null
    echo "  Removed [ $total ] files."
    echo;exit 0
fi

count=0
scr=$(realpath "$0")
dir=$(dirname "$scr")

for i in *.sh; do
    if [ "$i" != "cli-install.sh" ]; then
        if [ -f "/usr/local/bin/${i%%.sh}" ]; then
            sudo rm "/usr/local/bin/${i%%.sh}"
            sudo chmod -x "$dir/$i"
        fi
        if [ "$p" = "1" ]; then
            ln -s "$dir/$i" "/usr/local/bin/${i%%.sh}"
            sudo chmod +x "/usr/local/bin/${i%%.sh}"
        fi
        count=$((count + 1))
    fi
done

for i in *.py; do
    if [ -f "/usr/local/bin/${i%%.py}" ]; then
        sudo rm "/usr/local/bin/${i%%.py}"
        sudo chmod -x "$dir/$i"
    fi
    if [ "$p" = "1" ]; then
        ln -s "$dir/$i" "/usr/local/bin/${i%%.py}"
        sudo chmod +x "/usr/local/bin/${i%%.py}"
    fi
    count=$((count + 1))
done

for i in *.js; do
    if [ -f "/usr/local/bin/${i%%.js}" ]; then
        sudo rm "/usr/local/bin/${i%%.js}"
        sudo chmod -x "$dir/$i"
    fi
    if [ "$p" = "1" ]; then
        ln -s "$dir/$i" "/usr/local/bin/${i%%.js}"
        sudo chmod +x "/usr/local/bin/${i%%.js}"
    fi
    count=$((count + 1))
done

if [ "$p" = "1" ]; then
    echo "  Installed [ $count ] symlinks."
elif [ "$p" = "2" ]; then
    echo "  Uninstalled [ $count ] symlinks."
fi

echo
