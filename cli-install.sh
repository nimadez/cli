#!/bin/bash
#
# CLI Installer
#
# It just symlinks the 'cli.sh' to /usr/local/bin
# and adds execute permission to the /cli scripts.

echo
echo "  > github.com/nimadez/cli"
echo
printf "  \033[34m█ \033[0m ████ ██   ██ \n"
printf "  \033[32m █\033[0m ██   ██   ██ \n"
printf "  \033[31m█ \033[0m ████ ████ ██ \n"
echo
echo "  1. Install"
echo "  2. Uninstall"
read -p "  :  " act
echo;sudo -p "  Password: " chown -R $(whoami) /usr/local/bin

DIR=$(dirname $(realpath "$0"))

if [ "$act" = "1" ]; then

    sudo chmod +x ./*
    sudo chmod +x ./install/*
    sudo chmod +x ./patch/*
    sudo rm /usr/local/bin/cli 2>/dev/null
    ln -s $DIR/cli.sh /usr/local/bin/cli 2>/dev/null
    
    echo "  Installed."

elif [ "$act" = "2" ]; then

    sudo chmod -x ./*
    sudo chmod -x ./install/*
    sudo chmod -x ./patch/*
    sudo rm /usr/local/bin/cli 2>/dev/null

    echo "  Uninstalled."
    
fi

echo
