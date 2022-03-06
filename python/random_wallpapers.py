import os
import random


def remove_newlines(input_list):
    for index in range(0, len(input_list)):
        input_list[index] = input_list[index].replace('\n', '')
    return input_list


class RandomWallpapers:

    def __init__(self, initial_wallpaper_directory, initial_recent_wallpapers_filepath):
        self.wallpaper_directory = initial_wallpaper_directory
        self.recent_wallpapers_filepath = initial_recent_wallpapers_filepath
        self.wallpapers = []
        self.recent_wallpapers = []
        self.get_wallpapers()
        if not os.path.exists(self.recent_wallpapers_filepath):
            self.create_wallpaper_file()
        # os.system('gsettings set org.gnome.desktop.background picture-options "zoom"')

    def get_wallpapers(self):
        files = os.listdir(self.wallpaper_directory)
        for value in files:
            if ".png" in value or ".jpg" in value or ".JPG" in value or ".PNG" in value or ".tiff" in value or ".TIFF" in value:
                self.wallpapers.append(value)
        if len(self.wallpapers) == 0:
            raise Exception("Folder must contain at least one file with extension .png, .jpg, or .tiff")

    def get_recent_wallpapers(self):
        with open(self.recent_wallpapers_filepath, "r") as recent_wallpapers_file:
            self.recent_wallpapers = recent_wallpapers_file.readlines()

        remove_newlines(self.recent_wallpapers)

    def remove_recent_wallpapers(self):
        for value in self.recent_wallpapers:
            if value in self.wallpapers:
                self.wallpapers.remove(value)

        if len(self.wallpapers) == 0:
            self.create_wallpaper_file()
            self.get_wallpapers()

    def get_random_wallpaper(self):
        # print(len(self.wallpapers))
        random_wallpaper = random.choice(self.wallpapers)
        self.append_wallpaper(random_wallpaper)
        return self.wallpaper_directory + random_wallpaper

    def append_wallpaper(self, wallpaper):
        with open(self.recent_wallpapers_filepath, "a") as recent_wallpapers:
            recent_wallpapers.write(wallpaper)
            recent_wallpapers.write("\n")

    def create_wallpaper_file(self):
        with open(self.recent_wallpapers_filepath, 'w') as f:
            pass

    def set_random_wallpaper(self):
        # os.system(
        #     'gsettings set org.gnome.desktop.background picture-uri "file://' + self.get_random_wallpaper() + '"')
        os.system("./wallpapersetter " + self.get_random_wallpaper())
        os.system('notify-send "wallpaper changed"')
