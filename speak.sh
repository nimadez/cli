#!/bin/bash
#
# TTS synthesis engine
# more voices: http://cmuflite.org/packed/flite-2.0/voices/

if [ $# -eq 1 ]; then
    flite -t "$1"
else
    echo help: speak.sh [text]
fi
