#!/bin/bash
#
# Get group/user entries from administrative database

printf "[GROUPS]\n$(getent group)" | less -X
echo
printf "[USERS]\n$(getent passwd)" | less -X
echo
echo "[SUDOERS]"
getent group sudo
