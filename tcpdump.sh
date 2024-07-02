#!/bin/bash

sudo tcpdump -D
read -p "Interface: " interface
sudo tcpdump -i $interface
