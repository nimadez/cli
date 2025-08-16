#!/bin/bash
#
# Get apt history and what was done

cat /var/log/apt/history.log | less -M -X
