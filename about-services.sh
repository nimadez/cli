#!/bin/bash
#
# Get list of all active services

systemctl --type=service --state=active list-units
