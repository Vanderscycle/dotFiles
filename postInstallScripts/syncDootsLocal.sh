#!/bin/bash

declare -a StringArray=( ".gitconfig" ".tmux.conf" ".zshrc" ".zprofile" ".zlogout" ".zshenv" ".zlogin" ".gpg/gpg-agent")
DIR=${PWD%/*}
for DOTFILE in "${StringArray[@]}"; do
    # can't use symbolic link since we want the file
    # echo "~/Documents/dotFiles/$DOTFILE" ~/$DOTFILE
    rsync -av  --progress ~/Documents/dotFiles/$DOTFILE ~/$DOTFILE
done
# u does not overide (update)
rsync -av --progress  ~/Documents/dotFiles/lvim/ ~/.config/lvim/
rsync -av --progress  ~/Documents/dotFiles/postInstallScripts/endeavourOS/xmonad.hs ~/.xmomnad/
# rsync -auv --progress "/$DIR/lunarvim/" ~/.local/share/lunarvim
rsync -av --progress  ~/Documents/dotFiles/tmuxinator/ ~/.config/tmuxinator/ 
rsync -av --progress ~/Documents/dotFiles/kitty/ ~/.config/kitty/

lvim +PackerSync +qall
lvim +LspInstall svelte tsserver tailwindcss +qall
# lvim 
# maybe combine both bash files into a single on
