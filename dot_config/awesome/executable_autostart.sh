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
setxkbmap -layout "eu" -option "grp:alt_shift_toggle" &

run picom --experimental-backends
run nm-applet
run blueman-applet
run dunst
run insync start
