#!/bin/sh

lightred="#e06c75"
# darkred="#be5046"
green="#98c379"
# lightorange="#e5c07b"
darkorange="#d19a66"
blue="#61afef"
# magenta="#c678dd"
# cyan="#56b6c2"

# TODO: Cache weather data and display it over a day

# Network
# FIXME: This only works for wireless connections
ssid=$(iwconfig | grep ESSID | awk -F '"' '{ print $2 }')
if [ -n "$ssid" ]; then
    network="<span foreground='$blue'>$ssid</span>  "
fi

# Do-not-disturb
if $(makoctl mode | grep -q "do-not-disturb"); then
    dnd="<span foreground='$darkorange'>DND</span>  "
fi

# Battery info
if [ "$HOSTNAME" = "uraya" ]; then
    bat_color=$green
    bat_status=$(cat /sys/class/power_supply/BAT0/status \
        | awk '/Charging/ { print "+ " }')
    bat_charge=$(cat /sys/class/power_supply/BAT0/capacity)
    if [ "$charge" -lt 21 ]; then
        bat_color=$lightred
    fi
    bat="<span foreground='$bat_color'>$bat_status$bat_charge%</span>  "
fi
date=$(date +'%a %b %d %-H:%M:%S %Z')
echo "$dnd$bat$network$date"
