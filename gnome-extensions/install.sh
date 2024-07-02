#!/bin/bash

mkdir ~/.local/share/gnome-shell/extensions 2>/dev/null
rm -rf ~/.local/share/gnome-shell/extensions/panel-hwinfo@nimadez
rm -rf ~/.local/share/gnome-shell/extensions/panel-transparent@nimadez
cp -r panel-hwinfo@nimadez ~/.local/share/gnome-shell/extensions
cp -r panel-transparent@nimadez ~/.local/share/gnome-shell/extensions

echo finish installation.
echo 1\) logout and back \(or press Alt+F2 and run \'r\'\)
echo 2\) open Extensions
echo 3\) enable extensions
