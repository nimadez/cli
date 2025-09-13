#!/bin/bash
#
# Install minimal Labwc wayland compositor for experimental purposes
#
# $ labwc

sudo apt -y install --no-install-recommends labwc swaybg

# setup labwc
mkdir -p ~/.config/labwc
cp /usr/share/doc/labwc/autostart ~/.config/labwc/
cp /usr/share/doc/labwc/rc.xml ~/.config/labwc/
cp /etc/skel/.bashrc ~
sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/g' ~/.bashrc

# setup autostart
sed -i "s/swaybg -c '#113344'/swaybg -m center -c '#202024'/g" ~/.config/labwc/autostart

# setup theme (simple dark)
cat > ~/.config/labwc/themerc-override <<EOF
window.active.title.bg.color: #2B2A33
window.inactive.title.bg.color: #222226
window.active.label.text.color: #eeeeee
window.inactive.label.text.color: #aaaaaa
window.active.border.color: #353535
window.inactive.border.color: #353535
window.active.button.unpressed.image.color: #eeeeee
window.inactive.button.unpressed.image.color: #aaaaaa
menu.items.bg.color: #222226
menu.items.text.color: #eeeeee
menu.items.active.bg.color: #3584E4
menu.items.active.text.color: #222226
osd.bg.color: #3584E4
osd.border.color: #0B68D9
osd.label.text.color: #eeeeee
EOF

# setup menu
root_menu='
<item label="Terminal">
    <action name="Execute" command="x-terminal-emulator" />
</item>
'
cat > ~/.config/labwc/menu.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>

<openbox_menu>
    <!-- Note: for localization support of menu items "client-menu" has to be removed here -->
    <menu id="client-menu">
        <item label="Minimize">
            <action name="Iconify" />
        </item>
        <item label="Maximize">
            <action name="ToggleMaximize" />
        </item>
        <item label="Fullscreen">
            <action name="ToggleFullscreen" />
        </item>
        <item label="Roll Up/Down">
            <action name="ToggleShade" />
        </item>
        <item label="Decorations">
            <action name="ToggleDecorations" />
        </item>
        <item label="Always on Top">
            <action name="ToggleAlwaysOnTop" />
        </item>
        <!--
            Any menu with the id "workspaces" will be hidden
            if there is only a single workspace available.
            <menu id="client-send-to-menu" />
            openbox default workspace selector
            to use replace above workspace menu with the example below
            the label is required, but you can change the text.
            <menu id="client-send-to-menu" label="Send to..." />
        -->
        <item label="Close">
            <action name="Close" />
        </item>
    </menu>

    <menu id="root-menu">
        $root_menu
    </menu>

    <menu id="some-custom-menu">
        <item label="Reconfigure">
            <action name="Reconfigure" />
        </item>
        <separator />
        <item label="Exit">
            <action name="Exit" />
        </item>
    </menu>
</openbox_menu>
EOF

echo "done"
