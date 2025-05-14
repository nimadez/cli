#!/bin/bash
#
# Screencast a borderless gnome-terminal window

echo select a terminal window to start recording ...
echo [ press CTRL+C to stop ]

# crop borders (tab is not supported)
PX=26
PY=70
PW=52
PH=99

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
            -video_size "$((w-$PW))x$((h-$PH))" \
            -i "+$((x+$PX)),$((y+$PY))" \
            -lossless 1 \
            ~/Downloads/screencast_term.webp
}
