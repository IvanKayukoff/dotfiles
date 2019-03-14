#!/usr/bin/env sh

echo $1 | tee /sys/class/backlight/intel_backlight/brightness > /dev/null

