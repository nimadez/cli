#!/bin/bash
#
# Flush DNS cache

sudo resolvectl flush-caches
sudo service networking restart
