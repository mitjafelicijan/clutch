#!/usr/bin/env bash

set -e

# General settings for the Xephyr session.
DISPLAY_ID=50
RESOLUTION=1280x720
DPI=96
XEPHYR_FLAGS="-ac -br -noreset -no-host-grab"

# Used when downloading the source tarballs.
DWM_VERSION=6.5
DMENU_VERSION=5.3
ST_VERSION=0.9.2

# Check if GCC or Clang is installed.
if ! which gcc > /dev/null 2>&1 && ! which clang > /dev/null 2>&1; then
	echo "GCC or Clang is not installed. Please install either GCC or Clang to continue."
	exit 1
fi

# Check if wget is installed.
if ! which wget > /dev/null 2>&1; then
	echo "wget is not installed. Please install wget to continue."
	exit 1
fi

# Check if Xephyr is installed.
if ! which Xephyr > /dev/null 2>&1; then
	echo "Xephyr is not installed. Please install Xephyr to continue."
	exit 1
fi

# Function to display usage information.
usage() {
	echo "Usage: $0 [--bootstrap | --run]"
	echo "  --bootstrap    Downloads and compiles required software"
	echo "  --killall      Kills all running Xephyr and dwm instances"
	echo "  --run          Runs dwm session in Xephyr"
	echo "  --info         Displays all relavant paths and settings for Clutch"
	exit 1
}

# Check if no arguments are provided.
if [ $# -eq 0 ]; then
	usage
fi

# Fixes $XDG_CACHE_HOME path if not set and temporary sets it to ~/.cache if
# not set up by users profile.
if [ -z "$XDG_CACHE_HOME" ]; then
	XDG_CACHE_HOME="$HOME/.cache"
fi

CLUTCH_PATH="$XDG_CACHE_HOME/clutch"

# Loop until we find an available display number or reach max attempts
MAX_ATTEMPTS=50
ATTEMPTS=0
while [ -e "/tmp/.X11-unix/X$DISPLAY_ID" ]; do
	DISPLAY_ID=$((DISPLAY_ID + 1))
	ATTEMPTS=$((ATTEMPTS + 1))
	if [ $ATTEMPTS -ge $MAX_ATTEMPTS ]; then
		echo "No available display found after $MAX_ATTEMPTS attempts."
		exit 1
	fi
done

# Parses CLI arguments.
while [[ "$#" -gt 0 ]]; do
	case $1 in
		--bootstrap)
			echo "Downloading and compiling dependencies..."

			# Checks if $XDG_CACHE_HOME is set and uses that or uses ~/.cache.
			# https://wiki.archlinux.org/title/XDG_Base_Directory
			;;
		--killall)
			echo "Killing all the existing Xephyr and dwm instances..."
			pkill -9 Xephyr
			pkill -9 dwm
			;;
		--run)
			echo "Starting Xephyr..."

			# Fixes PATH which gets sent to dwm to make st and dmenu work.
			export PATH=`pwd`/vendor/dwm-$DWM_VERSION:$PATH
			export PATH=`pwd`/vendor/dmenu-$DMENU_VERSION:$PATH
			export PATH=`pwd`/vendor/st-$ST_VERSION:$PATH

			# Runs Xephyr and dwm.
			Xephyr $XEPHYR_FLAGS -resizeable -screen $RESOLUTION -dpi $DPI -title "Clutch:$DISPLAY_ID" :$DISPLAY_ID &
			sleep 1 # Give Xephyr a chance to properly start. 
			DISPLAY=:$DISPLAY_ID ./vendor/dwm-$DWM_VERSION/dwm
			;;
		info)
			echo "Information"
			;;
		*)
			usage
			;;
	esac
	shift
done

