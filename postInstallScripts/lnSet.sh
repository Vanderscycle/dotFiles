#!/bin/bash
echo $(pwd)
#https://linuxhint.com/bash_loop_list_strings/
# ".zshrc" ".oh-my-zsh" ".conda" ".alias"
# https://apple.stackexchange.com/questions/388622/zsh-zprofile-zshrc-zlogin-what-goes-where 
declare -a StringArray=( ".gitconfig" ".tmux.conf" ".zshrc" ".zprofile" ".zlogout" ".zshenv" ".zlogin" ".gpg/gpg-agent")
DIR=${PWD%/*}
for DOTFILE in "${StringArray[@]}"; do
    # can't use symbolic link since we want the file
    rsync -auv  ~/$DOTFILE "$DIR"
done
# https://stackoverflow.com/questions/4585929/how-to-use-cp-command-to-exclude-a-specific-directory
# of note you can do a dry run using -n
rsync -auv --progress ~/.config/lvim/ "$DIR/lvim/"
# rsync -auv --progress ~/.config/neomutt/ "/$DIR/neomutt/"
rsync -auv --progress ~/.config/tmuxinator/ "/$DIR/tmuxinator/"
rsync -auv --progress ~/.config/kitty/ "/$DIR/kitty/"
rsync -auv --progress ~/.local/share/lunarvim "/$DIR/lunarvim/"

#! should create a weekly upload schedule
