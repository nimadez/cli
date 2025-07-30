#!/bin/bash
#
# Discard changes

read -p "press enter to discard changes ..." p

git reset --hard HEAD
