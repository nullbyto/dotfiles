#!/usr/bin/env bash 

setxkbmap eu &
bash -c "input-remapper-control --command stop-all && input-remapper-control --command autoload" &
picom --experimental-backends &
feh --bg-fil ~/Pictures/Wallpapers/.wallpaper.jpg &
nm-applet &
blueman-applet &

