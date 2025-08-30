#!/bin/bash
#
# Install linux kernel headers

sudo apt install linux-headers-$(uname -r)

echo "done"
