#!/bin/bash

if [ `whoami` == root ]; then
    echo Please run this script without sudo
    exit
fi

config_directory="$HOME/.config/random-wallpaper/"
executable_path="$config_directory""python/wallpaper_randomizer_python"
wallpapers_directory="$HOME/Pictures/random-wallpapers/"
desktop_directory="$HOME/.local/share/applications/"
desktop_path="$desktop_directory""random-wallpaper.desktop"
forwarder_path="/usr/local/bin/random-wallpaper-forwarder"

# remove application files
if [ -d "$config_directory" ]; then
  echo "config dir"
  rm -r "$config_directory"
fi

# remove the locally created forwarder
if [ -f "random-wallpaper-forwarder" ]; then
    echo "local forwarder"
    rm random-wallpaper-forarder
fi

# remove the forwarder
if [ -f "$forwarder_path" ]; then
    echo "forwarder"
    sudo rm "$forwarder_path"
fi

# remove the desktop file
if [ -f "$desktop_path" ]; then
    echo "desktop"
    rm "$desktop_path"
fi

echo "random wallpapers is uninstalled"
