#!/bin/bash
echo $(pwd)
#https://linuxhint.com/bash_loop_list_strings/
# ".zshrc" ".oh-my-zsh" ".conda" ".alias"
declare -a StringArray=( ".gitconfig" ".vimrc" ".p10k.zsh" )
DIR=${PWD%/*}
for DOTFILE in "${StringArray[@]}"; do
    # can't use symbolic link since we want the file
    ln  ~/$DOTFILE "$DIR"
done
# You can't hardlink folders so we copy and replace
# cp -al ~/.config/nvim/ "$DIR"
# https://stackoverflow.com/questions/4585929/how-to-use-cp-command-to-exclude-a-specific-directory
# of note you can do a dry run using -n
rsync -av --progress ~/.config/nvim/ "$DIR/nvim" --exclude autoload/plugged/


#! should create a weekly upload schedule
# git add .*
