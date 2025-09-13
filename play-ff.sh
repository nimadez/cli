#!/bin/bash
#
# Stream audio and video urls using ffplay and ffprobe

if [ $# -eq 1 ]; then

    if ffprobe -v error -show_streams "$1" | grep -q "codec_type=video"; then

        ffplay -autoexit -framedrop \
                -reconnect 1 \
                -reconnect_on_network_error 1 \
                -reconnect_on_http_error 1 \
                -reconnect_at_eof 1 \
                -reconnect_streamed 1 \
                -i "$1"
    else

        ffplay -autoexit -nodisp \
                -reconnect 1 \
                -reconnect_on_network_error 1 \
                -reconnect_on_http_error 1 \
                -reconnect_at_eof 1 \
                -reconnect_streamed 1 \
                -i "$1"
    fi

else
    echo "Usage: play-ff.sh [audio/video url]"
fi
