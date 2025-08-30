#!/bin/bash
#
# Get list of groups

getent group | less -X

echo;echo "[sudoers]"
getent group sudo
echo
