#!/bin/bash

declare -a StringArray=( ".gitconfig" ".tmux.conf" ".zshrc" ".zprofile" ".zlogout" ".zshenv" ".zlogin" ".gpg/gpg-agent")
DIR=${PWD%/*}
for DOTFILE in "${StringArray[@]}"; do
    # can't use symbolic link since we want the file
    rsync -auv  "$DIR" ~/$DOTFILE
done

rsync -auv --progress "$DIR/nvim/" ~/.config/nvim/
#rsync -auv --progress "/$DIR/neomutt/" ~/.config/neomutt/ 
rsync -auv --progress "/$DIR/tmuxinator/" ~/.config/tmuxinator/ 
rsync -auv --progress "/$DIR/alacritty/" ~/.config/alacritty/ 

# maybe combine both bash files into a single on
