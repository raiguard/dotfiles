#!/bin/sh
# Invokes NNN to pick a file and opens the chosen file in kakoune.

start_location=$1 kak_client=$2 kak_session=$3
if ! [ -f "$start_location" ]; then
  start_location="$(dirname '$start_location')"
fi

tmp="${TMPDIR:-/tmp}/nnn_pick_$$"
nnn -p "$tmp" "$start_location"
filename=$(cat "$tmp")
rm "$tmp"

if [ -n "$filename" ]; then
  echo "evaluate-commands -client $kak_client 'edit \"$filename\"'" | kak -p $kak_session
fi
