#!/bin/bash

declare -a StringArray=( ".gitconfig" ".tmux.conf" ".zshrc" ".zprofile" ".zlogout" ".zshenv" ".zlogin" ".gpg/gpg-agent")
DIR=${PWD%/*}
for DOTFILE in "${StringArray[@]}"; do
    # can't use symbolic link since we want the file
    rsync -auv  "$DIR" ~/$DOTFILE
done
# u does not overide (update)
rsync -av --progress "$DIR/lvim/" ~/.config/lvim/
# rsync -auv --progress "/$DIR/lunarvim/" ~/.local/share/lunarvim
rsync -auv --progress "/$DIR/tmuxinator/" ~/.config/tmuxinator/ 
rsync -auv --progress "/$DIR/kitty/" ~/.config/kitty/

lvim +PackerSync +qall
lvim +LvimUpdate +qall
lvim +LspInstall svelte tsserver tailwindcss +qall
# lvim 
# maybe combine both bash files into a single on
