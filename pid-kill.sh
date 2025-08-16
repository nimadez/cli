#!/bin/bash
#
# Kill a process by PID

ps aux

read -p "PID: " pid
sudo kill -9 $pid
