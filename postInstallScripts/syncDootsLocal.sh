#!/bin/bash

declare -a StringArray=( ".gitconfig" ".tmux.conf" ".p10k.zsh" ".zshrc" ".zprofile" ".zlogout" ".zshenv" ".zlogin" ".gpg/gpg-agent")
DIR=${PWD%/*}
for DOTFILE in "${StringArray[@]}"; do
    # can't use symbolic link since we want the file
    # echo "~/Documents/dotFiles/$DOTFILE" ~/$DOTFILE
    rsync -av  --progress ~/Documents/dotFiles/$DOTFILE ~/$DOTFILE
done
# u does not overide (update)
rsync -av --progress  ~/Documents/dotFiles/lvim/ ~/.config/lvim/
# rsync -auv --progress "/$DIR/lunarvim/" ~/.local/share/lunarvim
rsync -av --progress  ~/Documents/dotFiles/tmuxinator/ ~/.config/tmuxinator/ 
rsync -av --progress ~/Documents/dotFiles/kitty/ ~/.config/kitty/
rsync -av --progress ~/Documents/dotFiles/.xmonad/ ~/.xmonad
rsync -av --progress ~/Documents/dotFiles/xmobar/ ~/.config/xmobar
rsync -av --progress ~/Documents/dotfiles/dunst/ ~/.config/dunst 
rsync -av --progress  ~/Documents/dotFiles/fontconfig/ ~/.config/fontconfig/


lvim +PackerSync +qall
# lvim +LspInstall svelte tsserver tailwindcss +qall
sudo pacman -Syu
xmonad --recompile
# lvim 
# maybe combine both bash files into a single on
