#!/bin/bash
#
# Purge home and apt packages

sudo resolvectl flush-caches

sudo apt autoremove --purge
sudo apt autoclean # clean obsolete debs
sudo apt clean # clean installer scripts

> ~/.bash_history
> ~/.python_history
> ~/.node_repl_history
