#!/bin/sh

pamixer &
/usr/lib/polkit-kde-authentication-agent-1 &

pw-metadata -n settings 0 clock.force-rate 44100

xrandr --output eDP --primary --mode 2880x1620 --rate 120 --output HDMI-A-0 --mode 3840x2160 --rate 30 --above eDP

xrdb -merge ~/.Xresources

get_datetime() {
    date +" %I:%M %p"
}

while true; do

		    VOL=$(pamixer --get-volume-human)
        MEM=$(free -h --kilo | awk '/^Mem:/ {print $3 "/" $2}')
        CPU=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}' )
		    WIFI=$(nmcli -f ACTIVE,SIGNAL dev wifi list | awk '$1=="yes" {print $2}')
        xsetroot -name "  $MEM| $CPU%| $VOL| $WIFI%|$(get_datetime)"
        sleep 10s
done &

hsetroot -solid "#1E1E2E"

picom -b

exec dwm
