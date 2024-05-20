#!/usr/bin/env sh

date=$(date +'%a %b %d')
if [ $(date +%Z) != "CEST" ]; then
  prague="$(TZ=Europe/Prague date +'%-H:%M %Z') "
fi
local=$(date +"%-H:%M %Z")
echo "$date $prague$local"
