playerctl $1
title=$(playerctl metadata | awk '/:title/ {print substr($0, index($0,$3))}')
artist=$(playerctl metadata | awk '/:artist/ {print substr($0, index($0,$3))}')
notify-send -u low -t 3000 "$title" "$artist"
