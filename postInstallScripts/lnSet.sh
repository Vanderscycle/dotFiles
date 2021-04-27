#!/bin/bash
echo $(pwd)
#https://linuxhint.com/bash_loop_list_strings/
# ".zshrc" ".oh-my-zsh" ".conda" ".alias"
declare -a StringArray=( ".gitconfig" ".tmux.conf" ".zshrc")
DIR=${PWD%/*}
for DOTFILE in "${StringArray[@]}"; do
    # can't use symbolic link since we want the file
    ln  ~/$DOTFILE "$DIR"
done
# You can't hardlink folders so we copy and replace
# cp -al ~/.config/nvim/ "$DIR"
# https://stackoverflow.com/questions/4585929/how-to-use-cp-command-to-exclude-a-specific-directory
# of note you can do a dry run using -n
rsync -auv --progress ~/.config/nvim/ "$DIR/nvim" --exclude autoload/plugged/ --exclude pack/ #deprecated
rsync -auv --progress ~/.config/ranger/ "$DIR/ranger" #deprecated
rsync -auv --progress ~/.config/nvim/lua/ "/$DIR/lua/"
rsync -auv --progress ~/.config/neomutt/ "/$DIR/neomutt/"
rsync -auv --progress ~/vimwiki "/$DIR/vimwiki/"
#! should create a weekly upload schedule
# git add .*
