#!/bin/bash
#
# Add styles to panel, such as transparency (customizable)

mkdir -p ~/.local/share/gnome-shell/extensions/panel-style@nimadez
cat > ~/.local/share/gnome-shell/extensions/panel-style@nimadez/stylesheet.css <<EOF

.panel-style {
    background-color: rgba(0, 0, 0, 0.0);
    box-shadow: none;
}

EOF

cat > ~/.local/share/gnome-shell/extensions/panel-style@nimadez/extension.js <<EOF
import { Extension } from 'resource:///org/gnome/shell/extensions/extension.js';
import { panel } from 'resource:///org/gnome/shell/ui/main.js';
export default class PanelStyle extends Extension {
    constructor(metadata) {
        super(metadata);
        this._uuid = metadata.uuid;
    }

    enable() {
        panel.add_style_class_name('panel-style');
    }

    disable() {
        panel.remove_style_class_name('panel-style');
    }
}
EOF

cat > ~/.local/share/gnome-shell/extensions/panel-style@nimadez/metadata.json <<EOF
{
    "name": "Panel Style",
    "description": "Add styles to panel",
    "shell-version": [ "48" ],
    "url": "https://github.com/nimadez/cli",
    "uuid": "panel-style@nimadez",
    "version": 1
}
EOF

echo "1. Press ALT + F2, type 'r' and enter"
echo "2. Open Extensions > enable 'Panel Style' (if not active)"
