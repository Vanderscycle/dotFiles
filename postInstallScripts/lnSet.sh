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
cp -al ~/.config/nvim/ "$DIR"
# .config file
if [ ! -f .config ]
then
    mkdir .config
fi
declare -a StringArray=("Code")
for DOTFILE in "${StringArray[@]}"; do
    echo $DOTFILE
    ln -s ~/.config/$DOTFILE "$(pwd)/.config/"
done

#! should create a weekly upload schedule
# git add .*
