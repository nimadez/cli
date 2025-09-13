#!/bin/bash
#
# Kills a process by PID, or kills all processes by name
# (recognizes numeric or string input to define a command)

kill_pid() {
    local PID="$1"
    if ! ps -p $PID >/dev/null; then
        echo "Process PID [$PID] is not running."
        exit 1
    else
        kill -9 "$PID"
    fi
}

kill_processes() {
    local NAME="$1"
    if ! pgrep -x "$NAME" >/dev/null; then
        echo "Process NAME [$NAME] is not running."
        exit 1
    else
        killall "$NAME"
    fi
}

if [ $# -eq 1 ]; then
    if expr "$1" : '^[0-9]*$' >/dev/null; then
        kill_pid "$1"
    elif expr "$1" : '^[a-zA-Z0-9]*$' >/dev/null && ! expr "$1" : '^[0-9]*$' >/dev/null; then
        kill_processes "$1"
    fi
else
    echo "Usage: kills.sh [pid/name]"
fi
