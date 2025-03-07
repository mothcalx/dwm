#!/bin/sh

pamixer &
/usr/lib/polkit-kde-authentication-agent-1 &

pw-metadata -n settings 0 clock.force-rate 44100

xrandr --output eDP --primary --mode 2880x1620 --rate 120 --output HDMI-A-0 --mode 3840x2160 --rate 60 --above eDP

xrdb -merge ~/.Xresources

ztatusbar 2> ztatusbar.log &

hsetroot -solid "#1E1E2E"

picom -b

exec dwm
