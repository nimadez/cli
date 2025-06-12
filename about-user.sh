#!/bin/bash
#
# Get list of all users and groups

echo [USERS]
getent passwd

echo;echo [GROUPS]
getent group

echo;echo [PERMISSIONS]
stat -c '%A %a %n' /*
