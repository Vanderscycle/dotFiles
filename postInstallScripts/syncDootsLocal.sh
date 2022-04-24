#!/bin/bash

declare -a StringArray=( ".xinitrc" ".gitconfig" ".p10k.zsh" ".tmux.conf" ".zshrc" ".zprofile" ".zlogout" ".zshenv" ".zlogin" ".gpg/gpg-agent")
for DOTFILE in "${StringArray[@]}"; do
    echo -e "\n=>${DOTFILE}::doots --> local"    

    rsync -av  --progress ~/Documents/dotFiles/$DOTFILE ~/$DOTFILE
done
    rsync -av --progress   ~/Documents/dotFiles/config.fish ~/.config/fish/config.fish
    rsync -av --progress  ~/Documents/dotFiles/.gnupg ~/.gnupg/ 
    rsync -av --progress  ~/Documents/dotFiles/ssh/ ~/.ssh/config 


rg --passthru 'henri' -r $DOOTS_USER_NAME ~/.zshrc > ~/.temp.txt && mv ~/.temp.txt ~/.zshrc.sh

declare -a ConfArray=("lvim" "broot" "tmuxinator" "zellij" "tmux" "kitty" "xmobar" "dunst" "fontconfig" "ag" "qutebrowser")
for CONF in "${ConfArray[@]}"; do
  echo -e "\n=>${CONF}::doots --> local"    
  rsync -av --progress ~/Documents/dotFiles/$CONF  ~/.config/
done
rsync -av --progress ~/Documents/dotFiles/.xmonad/ ~/.xmonad/

lvim +PackerSync +qall
