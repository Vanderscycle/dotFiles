#!/bin/bash
echo $(pwd)
#https://linuxhint.com/bash_loop_list_strings/
declare -a StringArray=(".zshrc" ".gitconfig" ".vscode" ".gitkraken")
for DOTFILE in "${StringArray[@]}"; do
    ln -s ~/$DOTFILE "$(pwd)/"
done