#!/bin/bash
#
# Permanently delete a file with no recovery

num1=$((RANDOM % 20 + 1))
num2=$((RANDOM % 20 + 1))
answer=$((num1 + num2))

if [ $# -eq 1 ]; then
    echo "What is the sum of $num1 and $num2?"
    read -p ": " p

    if [ "$p" = "" ]; then
        exit 0
    fi

    if [[ "$p" =~ ^-?[0-9]+$ && "$p" -eq "$answer" ]]; then
        shred -uvz "$1"
    else
        echo "You've lost your mind, try again later!"
    fi
else
    echo "help: shredder.sh [file]"
fi
