#!/bin/sh

light "$@"
out=$(printf %.0f $(light -G))
notify-send -u low -h int:value:$out -h string:x-dunst-stack-tag:brightness -t 1500 -c system "brightness - $out %"
