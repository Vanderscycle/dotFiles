#!/bin/bash

declare -a StringArray=( ".xinitrc" ".gitconfig" ".p10k.zsh" ".tmux.conf" ".zshrc" ".zprofile" ".zlogout" ".zshenv" ".zlogin" ".gpg/gpg-agent")
for DOTFILE in "${StringArray[@]}"; do
    # can't use symbolic link since we want the file
    # echo "~/Documents/dotFiles/$DOTFILE" ~/$DOTFILE
    rsync -av  --progress ~/Documents/dotFiles/$DOTFILE ~/$DOTFILE
done

rg --passthru 'henri' -r $DOOTS_USER_NAME ~/.zshrc > ~/.temp.txt && mv ~/.temp.txt ~/.zshrc.sh

declare -a ConfArray=("lvim" "fish" "broot" "tmuxinator" "zellij" "tmux" "kitty" "xmobar" "dunst" "fontconfig")
for CONF in "${ConfArray[@]}"; do
  echo -e "\n=>${CONF}::doots --> local"    
  rsync -auv --progress ~/Documents/dotFiles/$CONF  ~/.config/$CONF
done
rsync -av --progress ~/Documents/dotFiles/.xmonad/ ~/.xmonad/

lvim +PackerSync +qall
