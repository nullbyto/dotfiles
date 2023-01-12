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
setxkbmap -layout "eu" &

run picom -b
run nm-applet
run blueman-applet
run dunst
run insync start
run emacs --daemon
