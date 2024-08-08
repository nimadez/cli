#!/bin/bash

# 'unrar' package is a non-free software,
# so I prefer to use my older copy on wine

# I no longer use rar to create archives,
# because this format is currently mostly
# used to transfer password-protected
# malware and cracked software.

wine /media/$USER/local/apps/.windows/unrar.exe "$@"
