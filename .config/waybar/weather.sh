#!/bin/sh

weather=$(curl 'https://wttr.in/?format=1')

echo "$weather\n\nweather"
