#!/bin/bash

sudo apt -y install wine

sudo dpkg --add-architecture i386
sudo apt update
sudo apt -y install wine32:i386
