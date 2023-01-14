#!/bin/sh
MODE=$1

export w=$(xdotool getactivewindow)
xdotool search --onlyvisible --class Zathura windowactivate
sleep 0.1

if [[ $MODE = "down" ]]; then
    xdotool key Page_Down
else
    xdotool key Page_Up
fi

xdotool windowactivate $w
