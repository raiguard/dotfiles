#!/bin/sh

pamixer -$1 5
vol=$(pamixer --get-volume)
dunstify -u low -h int:value:$vol -h string:x-dunst-stack-tag:volume -t 1500 "Volume - $vol%"
