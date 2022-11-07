#!/bin/bash

declare -a StringArray=( ".xinitrc" ".gitconfig" ".gitconfig.personal" ".p10k.zsh" ".gpg/gpg-agent" ".condarc" ".vale.ini" "zettlekasten")
for DOTFILE in "${StringArray[@]}"; do
    echo -e "\n=>${DOTFILE}::doots --> local"    

    rsync -av  --progress ~/Documents/dotFiles/.config/$DOTFILE ~/
done
    rsync -av --progress   ~/Documents/dotFiles/config.fish ~/.config/fish/config.fish
    rsync -av --progress  ~/Documents/dotFiles/.gnupg ~/.gnupg/ 
    rsync -av --progress  ~/Documents/dotFiles/ssh/ ~/.ssh/config 

rg --passthru 'henri' -r $DOOTS_USER_NAME ~/.zshrc > ~/.temp.txt && mv ~/.temp.txt ~/.zshrc.sh

declare -a ConfArray=("lvim" "broot""zellij" "kitty" "xmobar" "dunst" "fontconfig" "ag" "qutebrowser" "mimeapps.list" "bat" "rg" "neofetch" "picom" "k9s")
for CONF in "${ConfArray[@]}"; do
  echo -e "\n=>${CONF}::doots --> local"    
  rsync -av --progress ~/Documents/dotFiles/.config/$CONF  ~/.config/
done
rsync -av --progress ~/Documents/dotFiles/.xmonad/ ~/.xmonad/

rsync -av --progress   ~/Documents/dotFiles/etc/fstab /etc/fstab
rsync -av --progress   ~/Documents/dotFiles/etc/nvidia.hook /etc/pacman.d/hooks/nvidia.hook
lvim +PackerSync +qall
