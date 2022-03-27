#!/bin/sh

utilization=$(cat /sys/class/drm/card0/device/gpu_busy_percent)
vram_used=$(cat /sys/class/drm/card0/device/mem_info_vram_used)
vram_used_mb=$(echo "$vram_used / 1024 / 1024" | bc -l)
temp=$(cat /sys/class/drm/card0/device/hwmon/hwmon1/temp1_input)

printf "%0.0f%% / %0.0f MB /" $utilization $vram_used_mb
