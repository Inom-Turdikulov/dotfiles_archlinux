#!/usr/bin/env sh

if [ -d "$HOME/Pictures/wallpapers/" ]; then
   wfile=$(find ~/Pictures/wallpapers/*.jpg -type f | shuf -n 1)
   ext="${wfile##*.}"
   if [ "$ext" == jpg ]; then
      feh --bg-fill $wfile &
   fi
fi
