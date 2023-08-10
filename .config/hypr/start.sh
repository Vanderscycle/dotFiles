#!/bin/bash

# iniciar o wallpaper engine
swww init &
swww img ~/Pictures/switch.png &

fcitx5 &
# network manager
# nm-applet --indicator &

# barra de infos
waybar &

# dunst
# dunst
