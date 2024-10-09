#!/bin/bash
#
# Record a gnome window without title

echo select a window to start recording ...
echo [ press CTRL+C to stop ]

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

    for i in 3 2 1; do echo "$i"; sleep 1; done
    echo "start recording ..."; sleep 1;
    
    ffmpeg  -y -f x11grab -show_region 1 -framerate 20 \
            -video_size "$((w))x$((h))" \
            -i "+$((x)),$((y))" \
            -lossless 1 \
            ~/Downloads/recwin.webp
}
