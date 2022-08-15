#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@" &
  fi
}

systemctl --user start xremap &
#feh --bg-fil ~/Pictures/Wallpapers/.wallpaper.jpg &
nitrogen --restore &

run picom --experimental-backends
run nm-applet
run blueman-applet
run dunst
