#!/bin/bash
#
# Take a gnome window screenshot without title

echo select a window ...

xwininfo | {
    while IFS=: read -r k v; do
        case "$k" in
            *"Absolute upper-left X"*) x=$v;;
            *"Absolute upper-left Y"*) y=$v;;
            *"Border width"*) bw=$v;;
            *"Width"*) w=$v;;
            *"Height"*) h=$v;;
        esac
    done
    
    ffmpeg  -y -f x11grab -show_region 1 -framerate 20 \
            -video_size "$((w))x$((h))" \
            -i "+$((x)),$((y))" \
            ~/Downloads/screenshot.png
}
