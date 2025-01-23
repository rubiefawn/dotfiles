#!/bin/sh
# This script will choose a random file from a given directory at regular intervals and set it as the wallpaper

if [[ $# -lt 1 ]] || [[ ! -d $1 ]]; then
	echo "Usage:
	$0 <dir containing images> [interval in seconds]"
	exit 1
fi

export SWWW_TRANSITION_FPS=60
export SWWW_TRANSITION_STEP=2

while true; do
	find "$1" -type f \
	| while read -r img; do
		echo "$(</dev/urandom tr -dc a-zA-Z0-9 | head -c 8):$img"
	done \
	| sort -n | cut -d':' -f2- \
	| while read -r img; do
		swww img "$img"
		sleep ${2:-600} # Default interval of 600s if not specified
	done
done

# The following is cleaner, but does not work on Busybox, since it
# doesn't have sort -R

# while true; do
# 	find "$1" -type f | sort -R | while read -r img; do
# 		swww img "$img"
# 		sleep $INTERVAL
# 	done
# done
