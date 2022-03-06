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

if [ ! -d "$wallpapers_directory" ]; then
  mkdir "$wallpapers_directory"
fi

if [ ! -d "$config_directory" ]; then
  mkdir "$config_directory"
fi

# create the forwarder and send it to /usr/local/bin
if [ -f "random-wallpaper-forwarder" ]; then
    rm random-wallpaper-forarder
fi
touch random-wallpaper-forwarder
echo '#!/bin/bash' > random-wallpaper-forwarder
echo "cd $config_directory""python/" >> random-wallpaper-forwarder
echo "$executable_path ""-w $wallpapers_directory" >> random-wallpaper-forwarder
chmod +x random-wallpaper-forwarder
sudo cp random-wallpaper-forwarder /usr/local/bin/

# make sure there is at least one wallpaper, and a pretty nice one at that
cp benjamin-voros-phIFdC6lA4E-unsplash.jpg "$wallpapers_directory"
# copy over the project files (the forwarder points to here)
cp -r python "$config_directory"
# copy the desktop file, this is useful for setting the program to start on boot
if [ -f "$desktop_path" ]; then
    rm "$desktop_path"
fi
cp random-wallpaper.desktop "$HOME"/.local/share/applications/

# cron_entry="@reboot sleep 60 && random-wallpaper-forwarder"
# crontab -l > crontab_new
# if !(grep -Fxq "$cron_entry" crontab_new)
# then
#     echo "$cron_entry" >> crontab_new
#     crontab crontab_new
# fi
# rm crontab_new
echo "random wallpapers is installed"
echo "please place wallpapers in ~/Pictures/random-wallpapers/"
echo "wallpapers must be in format .png, .jpg, or .tiff"
echo
echo "if you would like to run this program at boot please configure the desktop"
echo "application \"random-wallpaper\" to start on boot."
echo "The method varies between desktops but on gnome you use gnome-tweaks"
echo
echo "To change the wallpaper manually, open the random-wallpaper app"
