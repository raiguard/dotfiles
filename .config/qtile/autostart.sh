#!/bin/sh
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &	# Graphical authentication agent
xrandr --output DP-0 --off --output DP-1 --off --output HDMI-0 --off --output DP-2 --mode 2560x1440 --pos 2560x0 --rotate normal --output DP-3 --off --output DP-4 --mode 2560x1440 --pos 0x0 --rotate normal --output DP-5 --off --output USB-C-0 --off & # Screen layout
redshift & # Screen dimming and night shift
~/.nfancurve/temp.sh & # NVIDIA fan curves
udiskie & # Disk auto-mounting
