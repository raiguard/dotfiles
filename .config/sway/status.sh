#!/bin/sh

red="#f7768e"
green="#9ece6a"
yellow="#e0af68"
orange="#ff9e64"
blue="#7aa2f7"
magenta="#bb9af7"
cyan="#7dcfff"

hwmon=$(find /sys/class/drm/card1/device/hwmon -type d -name hwmon[0-9])

while true; do
    # CPU info
    cpuusage=$(mpstat 1 1 | awk '/M  all/ { printf "%.1f%%", 100 - $13 }')
    cputemp=$(sensors | awk '
      /Package/ { printf "%.0f°C\n", substr($4, 2, length($4) - 3) }
      /Tdie/ { printf "%.0f°C\n", substr($2, 2, length($2) - 2) }
    ' | head -1)
    if [ -n "$cputemp" ]; then
      cputemp="  $cputemp"
    fi
    cpu="<span foreground='$magenta'>$cpuusage$cputemp</span>  "

    # RAM info
    used=$(free | awk '/Mem/ { printf "%.2f \n", $3/1024/1024 }')
    ram="<span foreground='$cyan'>${used}GB</span>  "

    # Network
    ssid=$(nmcli connection show --active | grep wifi | cut -f 1 -d " ")
    if [ -n "$ssid" ]; then
        network="<span foreground='$blue'>$ssid</span>  "
    else
        network=""
    fi

    # GPU
    if [ "$HOSTNAME" = "tantal" ]; then
        gpubusy=$(cat "/sys/class/drm/card1/device/gpu_busy_percent")
        gputemp=$(cat "$hwmon/temp1_input")
        gputemp=$(expr $gputemp / 1000)
        gpu="<span foreground='$red'>$gpubusy%  $gputemp°C</span>  "
    fi

    # Do-not-disturb
    if $(makoctl mode | grep -q "do-not-disturb"); then
        dnd="<span foreground='$orange'>DND</span>  "
    fi

    # Battery info
    if [ "$HOSTNAME" = "uraya" ]; then
        # Pen tablet
        tablet_path=$(upower -d | grep Device: | grep wacom_battery \
            | awk '{ print $2 }')
        if [ -n "$tablet_path" ]; then
            tablet_info=$(upower -i "$tablet_path")
            tablet_color=$green
            tablet_charge=$(echo "$tablet_info" | grep percentage \
                | awk '{ print $2 }' | sed "s/%//")
            if [ "$tablet_charge" -lt 21 ]; then
                tablet_color=$red
            fi
            tablet_status=$(echo "$tablet_info" | grep "power supply" \
                | awk '/yes/ { print "+" }')
            tablet_bat="<span foreground='$tablet_color'>T:$tablet_status$tablet_charge%</span>  "
        else
            tablet_bat=""
        fi
        # Laptop
        bat_color=$green
        bat_status=$(cat /sys/class/power_supply/BAT1/status \
            | awk '/Charging/ { print "+" }')
        bat_charge=$(cat /sys/class/power_supply/BAT1/capacity)
        if [ "$bat_charge" -lt 21 ]; then
            bat_color=$red
        fi
        # Wattage
        bat_wattage=$(echo - | awk "{printf \"%.1f\", \
          $(( \
            $(cat /sys/class/power_supply/BAT1/current_now) * \
            $(cat /sys/class/power_supply/BAT1/voltage_now) \
          )) / 1000000000000 }")
        bat="$tablet_bat<span foreground='$bat_color'>$bat_status$bat_charge%  $bat_wattage W</span>  "
    fi
    date=$(date +'%a %b %d')
    if [ $(date +%Z) != "CEST" ]; then
      prague="$(TZ=Europe/Prague date +'%-H:%M %Z') "
    fi
    local=$(date +"%-H:%M %Z")
    echo "$cpu$ram$gpu$dnd$bat$network$date $prague$local"
done
