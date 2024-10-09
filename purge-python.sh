#!/bin/bash
#
# Purge pycache of all subdirectories

sudo python3 -Bc "import pathlib; [p.unlink() for p in pathlib.Path('.').rglob('*.py[co]')]"
sudo python3 -Bc "import pathlib; [p.rmdir() for p in pathlib.Path('.').rglob('__pycache__')]"

echo This only applied to subdirectories.
echo Done
