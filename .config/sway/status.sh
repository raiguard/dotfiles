# lightred="#e06c75"
darkred="#be5046"
green="#98c379"
# lightorange="#e5c07b"
# darkorange="#d19a66"
blue="#61afef"
# magenta="#c678dd"
# cyan="#56b6c2"

# TODO: Cache wttr.in and display it over a day

# IP address
ip_address=$(ip -br address | grep UP | head -1 | awk '{ print $1 " " $3 }' | sed "s/\\/.*//")
if [ -n "$ip_address" ]; then
    ip_address="<span foreground='$blue'>$ip_address</span>  "
fi

# Battery info
if [ "$HOSTNAME" = "uraya" ]; then
    bat_color=$green
    charge=$(cat /sys/class/power_supply/BAT0/capacity)
    if [ "$charge" -lt 21 ]; then
        bat_color=$darkred
    fi
    bat="<span foreground='$bat_color'>$charge%</span>  "
fi
date=$(date +'%a %b %d %-H:%M:%S %Z')
echo "$bat$ip_address$date"
