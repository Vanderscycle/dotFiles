#!/bin/bash
echo $(pwd)
#https://linuxhint.com/bash_loop_list_strings/
# ".zshrc" ".oh-my-zsh" ".conda" ".alias"
# https://apple.stackexchange.com/questions/388622/zsh-zprofile-zshrc-zlogin-what-goes-where 
declare -a StringArray=(".xinitrc" ".gitconfig" ".p10k.zsh" ".tmux.conf" ".zshrc" ".zprofile" ".zlogout" ".zshenv" ".zlogin" ".gpg/gpg-agent" ".ripgreprc")
for DOTFILE in "${StringArray[@]}"; do
    # can't use symbolic link since we want the file
    rsync -auv --progress  ~/$DOTFILE ~/Documents/dotFiles/$DOTFILE
done
# https://stackoverflow.com/questions/4585929/how-to-use-cp-command-to-exclude-a-specific-directory
# of note you can do a dry run using -n
declare -a ConfArray=("lvim","fish","broot","tmuxinator","zellij","tmux", "kitty", "xmobar", "dunst","fontconfig")
for CONF in "${ConfArray[@]}"; do
  echo -e "\n=>${CONF}::local -> doots"    
  rsync -auv --progress  ~/.config/$CONF ~/Documents/dotFiles/$CONF
done
rsync -av --progress  ~/.xmonad/ ~/Documents/dotFiles/.xmonad/

# rsync -av --progress ~/.config/lvim/ ~/Documents/dotFiles/lvim/
# rsync -av --progress  ~/.config/fish/ ~/Documents/dotFiles/fish/
# rsync -av --progress ~/.config/broot/ ~/Documents/dotFiles/broot
# rsync -av --progress ~/.config/tmuxinator/ ~/Documents/dotFiles/tmuxinator/
# rsync -av --progress ~/.config/zellij/ ~/Documents/dotFiles/zellij/
# rsync -av --progress ~/.config/tmux/ ~/Documents/dotFiles/tmux/
# rsync -av --progress ~/.config/kitty/ ~/Documents/dotFiles/kitty/
# rsync -av --progress ~/.config/xmobar/ ~/Documents/dotFiles/xmobar/
# rsync -av --progress ~/.config/dunst/ ~/Documents/dotFiles/dunst/
# rsync -av --progress ~/.config/fontconfig/ ~/Documents/dotFiles/fontconfig/ # fonts.conf


# rsync -auv --progress ~/.local/share/lunarvim "/$DIR/lunarvim/"

#! should create a weekly upload schedule
