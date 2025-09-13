#!/bin/bash
#
# A simple extension to load user theme
#
# - Extension directory: ~/.local/share/gnome-shell/extensions
# - User theme directory: ~/.local/share/gnome-shell/themes/user
#
# - You can copy any theme to the user directory
# - You don't need to run this script again to update the theme

mkdir -p ~/.local/share/gnome-shell/extensions/user-theme@nimadez
mkdir -p ~/.local/share/gnome-shell/themes/user

# metadata.json
cat > ~/.local/share/gnome-shell/extensions/user-theme@nimadez/metadata.json <<EOF
{
    "name": "User Theme",
    "description": "A user-theme extension",
    "shell-version": [ "48" ],
    "url": "https://github.com/nimadez/cli",
    "uuid": "user-theme@nimadez",
    "version": 1
}
EOF

# extension.js
cat > ~/.local/share/gnome-shell/extensions/user-theme@nimadez/extension.js <<EOF
import { Extension } from 'resource:///org/gnome/shell/extensions/extension.js';
import { setThemeStylesheet, loadTheme } from 'resource:///org/gnome/shell/ui/main.js';
export default class UserTheme extends Extension {
    constructor(metadata) {
        super(metadata);
        this._uuid = metadata.uuid;
    }

    enable() {
        const stylesheet = "/home/$USER/.local/share/gnome-shell/themes/user/gnome-shell.css";
        setThemeStylesheet(stylesheet);
        loadTheme();
    }

    disable() {
        setThemeStylesheet(null);
        loadTheme();
    }
}
EOF

# add a basic theme (transparent panel)
cat > ~/.local/share/gnome-shell/themes/user/gnome-shell.css <<EOF
#panel {
    background-color: rgba(0, 0, 0, 0.0);
}
EOF

# enable extension
# Notice: This is the only extension installed on my GNOME, if you have more extensions it will disable the others.
gsettings set org.gnome.shell enabled-extensions "['user-theme@nimadez']"

echo "user-theme@nimadez extension installed."
echo "Press ALT + F2, type 'r' and enter (or login again)"
