#!/bin/sh

playerctl $1
sleep 0.1
title=$(playerctl metadata | awk '/:title/ {print substr($0, index($0,$3))}')
if [ -n "$title" ]; then
    artist=$(playerctl metadata | awk '/:artist/ {print substr($0, index($0,$3))}')
    notify-send -u low -t 3000 -h string:x-dunst-stack-tag:media -c system "$title" "$artist"
fi
