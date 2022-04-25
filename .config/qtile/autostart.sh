#!/bin/sh

~/bin/to-desk # Screens, audio sink, and wallpapers

picom & # Compositor
/usr/bin/polkit-dumb-agent & # Graphical authentication agent
udiskie --tray & # Disk auto-mounting and tray icon
nm-applet & # Network status in system tray
blueman-applet & # Bluetooth status in system tray
pasystray & # Volume control in system tray
redshift -o & # Only run once - letting it run continually causes stuttering
