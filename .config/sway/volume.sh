pamixer -$1 5
vol=$(pamixer --get-volume)
voldisp=$(pamixer --get-volume-human)
notify-send -u low -h int:value:$vol -h string:x-dunst-stack-tag:volume -t 1500 -c system "volume - $voldisp"
