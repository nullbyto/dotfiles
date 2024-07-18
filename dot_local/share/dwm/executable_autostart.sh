#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@" &
  fi
}

systemctl --user start xremap &
setxkbmap -layout "eu" &

# Screen settings
#xrandr --output DP-0 --mode 1920x1080 --rate 144
~/.screenlayout/default.sh

feh --bg-fill ~/Pictures/Wallpapers/wallpaper.jpg &
#nitrogen --restore &

run picom -b
run nm-applet
run blueman-applet
run dunst
run emacs --daemon
run dwmblocks
run sxhkd
run /usr/lib/xfce-polkit/xfce-polkit
XDG_CURRENT_DESKTOP=GNOME run insync start
