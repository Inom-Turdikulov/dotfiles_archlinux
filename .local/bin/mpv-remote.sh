#!/bin/sh

# Commands examples

# cycle pause
# playlist-next
# playlist-previous
# playlist-prev
# seek +20
# seek -20

echo "$@" | socat - $XDG_RUNTIME_DIR/mpv.socket


