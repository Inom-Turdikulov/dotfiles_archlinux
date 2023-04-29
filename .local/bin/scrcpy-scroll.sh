#!/bin/sh
MODE=$1
APP=scrcpy

export w=$(xdotool getactivewindow)
xdotool search --onlyvisible --class $APP windowactivate
sleep 0.2

if [[ $MODE = "down" ]]; then
    for i in {1..5}; do
        xdotool key Down
    done
else
    for i in {1..5}; do
        xdotool key Up
    done
fi

xdotool windowactivate $w
