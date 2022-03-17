#!/bin/sh

pamixer -$1 5
vol=$(pamixer --get-volume)
notify-send -u low -h int:value:$vol Volume
