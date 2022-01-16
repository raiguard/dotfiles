#!/bin/sh

# We want xrandr to finish before qtile fully boots
xrandr --output DP-0 --off --output DP-1 --off --output HDMI-0 --off --output DP-2 --mode 2560x1440 --pos 2560x0 --rotate normal --output DP-3 --off --output DP-4 --mode 2560x1440 --pos 0x0 --rotate normal --output DP-5 --off --output USB-C-0 --off

# Run these in the background
picom & # Compositor
/usr/bin/polkit-dumb-agent & # Graphical authentication agent
redshift-gtk & # Screen dimming and night shift
nfancurve -c ~/.config/nfancurve.conf & # NVIDIA fan curves
udiskie --tray & # Disk auto-mounting and tray icon
nm-applet & # Network status in system tray
blueman-applet & # Bluetooth status in system tray
pasystray & # Volume control in system tray
