#!/bin/bash
#
# Kill a process by PID

ps aux
#ps -ef

read -p "PID: " pid
sudo kill -9 $pid
