#!/bin/bash
echo $(pwd)
#https://linuxhint.com/bash_loop_list_strings/
# ".zshrc" ".oh-my-zsh" ".conda" ".alias"
# https://apple.stackexchange.com/questions/388622/zsh-zprofile-zshrc-zlogin-what-goes-where 
declare -a StringArray=( ".gitconfig" ".p10k.zsh" ".tmux.conf" ".zshrc" ".zprofile" ".zlogout" ".zshenv" ".zlogin" ".gpg/gpg-agent")
DIR=${PWD%/*}
for DOTFILE in "${StringArray[@]}"; do
    # can't use symbolic link since we want the file
    rsync -auv  ~/$DOTFILE "~/Documents/dotFiles/$DIR"
done
# https://stackoverflow.com/questions/4585929/how-to-use-cp-command-to-exclude-a-specific-directory
# of note you can do a dry run using -n
rsync -av --progress ~/.config/lvim/ ~/Documents/dotFiles/lvim
# rsync -auv --progress ~/.config/neomutt/ "/$DIR/neomutt/"
rsync -av --progress ~/.config/tmuxinator/ ~/Documents/dotFiles/tmuxinator/
rsync -av --progress ~/.config/kitty/ ~/Documents/dotFiles/kitty/
rsync -av --progress  ~/.xmonad/ ~/Documents/dotFiles/.xmonad/
rsync -av --progress ~/.config/xmobar/ ~/Documents/dotFiles/xmobar/
rsync -av --progress ~/.config/dunst/ ~/Documents/dotFiles/dunst/

# rsync -auv --progress ~/.local/share/lunarvim "/$DIR/lunarvim/"

#! should create a weekly upload schedule
