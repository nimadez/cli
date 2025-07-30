#!/bin/bash
#
# Displays a list of installed scripts

echo Total Scripts: $(ls /usr/local/bin/ | wc -l)

ls /usr/local/bin/
