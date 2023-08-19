#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@" &
  fi
}

#systemctl --user start xremap &
#feh --bg-fil ~/Pictures/Wallpapers/.wallpaper.jpg &
setxkbmap -layout "eu" &

# Screen settings
#xrandr --output DP-0 --mode 1920x1080 --rate 144
~/.screenlayout/default.sh

# Turn mouse acceleration off and make sense 0.5 times slower
xinput --set-prop "Compx Pulsar Xlite Wireless" 'libinput Accel Speed' -0.5
xinput --set-prop "Compx Pulsar Xlite Wireless" 'libinput Accel Profile Enabled' 0, 1

nitrogen --restore &

#run picom -b
run nm-applet
run blueman-applet
run dunst
run insync start
run emacs --daemon
run dwmblocks
