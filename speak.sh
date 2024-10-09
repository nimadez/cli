#!/bin/bash
#
# TTS synthesis engine
# speaks the text with an American-English Female voice
# less robotic voices than eSpeak
# more voices: http://cmuflite.org/packed/flite-2.0/voices/

if [ $# -eq 1 ]; then
    flite -t "$1" -voice ~/.config/flite/cmu_us_slt.flitevox
else
    echo help: speak.sh [text]
fi
