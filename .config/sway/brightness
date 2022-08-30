#!/bin/sh

brightnessctl s $1
out=$(printf %.0f $(echo "$(brightnessctl g) / $(brightnessctl m) * 100" | bc -l))
notify-send -u low -h int:value:$out -h string:x-dunst-stack-tag:brightness -t 1500 -c system "brightness - $out%"
