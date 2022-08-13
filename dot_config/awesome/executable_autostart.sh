#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@" &
  fi
}

#bash -c "input-remapper-control --command stop-all && input-remapper-control --command autoload" &
bash -c "input-remapper-control --command autoload" &
#feh --bg-fil ~/Pictures/Wallpapers/.wallpaper.jpg &
nitrogen --restore &

run picom --experimental-backends
run nm-applet
run blueman-applet
run dunst
