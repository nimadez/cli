#!/bin/bash

# install linux kernel headers

sudo apt update
sudo apt -y install linux-headers-$(uname -r)
