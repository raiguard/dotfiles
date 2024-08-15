#!/bin/sh

pamixer -$1 5
vol=$(pamixer --get-volume)
voldisp=$(pamixer --get-volume-human)
mpv /usr/share/sounds/gnome/default/alerts/click.ogg & disown
notify-send -u low -h int:value:$vol -h string:x-dunst-stack-tag:volume -t 1500 -c system "volume - $voldisp"
