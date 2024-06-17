#!/usr/bin/env bash

# General settings for the Xephyr session.
DISPLAY_ID=99
RESOLUTION=1280x720
DPI=96
XEPHYR_FLAGS="-ac -br -noreset -no-host-grab"

# Used when downloading the source tarballs from the Suckless website.
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
	exit 1
}

# Check if no arguments are provided.
if [ $# -eq 0 ]; then
	usage
fi

while [[ "$#" -gt 0 ]]; do
	case $1 in
		--bootstrap)
			echo "Downloading and compiling dependencies..."
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
			Xephyr $XEPHYR_FLAGS -resizeable -screen $RESOLUTION -dpi $DPI :$DISPLAY_ID &
			sleep 1 # Give Xephyr chance to properly start. 
			DISPLAY=:$DISPLAY_ID ./vendor/dwm-$DWM_VERSION/dwm
			;;
		*)
			usage
			;;
	esac
	shift
done

