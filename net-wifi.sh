#!/bin/bash
#
# List wifi networks

nmcli radio wifi on
nmcli dev wifi list
