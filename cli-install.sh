#!/bin/bash
#
# CLI Installer

echo "  FORK ME https//github.com/nimadez/cli"
echo "   ______    __        __              "
echo "  /\  ___\  /\ \      /\ \    X LINUX X"
echo "  \ \ \____ \ \ \____ \ \ \   DEBIAN OS"
echo "   \ \_____\ \ \_____\ \ \_\  ASSISTANT"
echo "    \/_____/  \/_____/  \/_/  @ nimadez"
echo
echo "  1. Install"
echo "  2. Uninstall"
read -p "  :  " act
echo;sudo -p "  Password: " chown -R $(whoami) /usr/local/bin

SCR=$(realpath "$0")
DIR=$(dirname "$SCR")

if [ "$act" = "1" ]; then

    echo "$DIR" > /usr/local/bin/cli.cfg
    sudo rm /usr/local/bin/cli 2>/dev/null
    ln -s "$DIR/cli.sh" /usr/local/bin/cli 2>/dev/null

    sudo chmod +x ./*
    sudo chmod +x /usr/local/bin/cli

    echo "  Installed."

elif [ "$act" = "2" ]; then

    sudo chmod -x ./*
    sudo chmod -x "/usr/local/bin/cli" 2>/dev/null

    sudo rm /usr/local/bin/cli.cfg 2>/dev/null
    sudo rm /usr/local/bin/cli 2>/dev/null

    echo "  Uninstalled."
    
fi

echo
