#!/bin/bash
echo $(pwd)
#https://linuxhint.com/bash_loop_list_strings/
# ".zshrc" ".oh-my-zsh" ".conda" ".alias"
# https://apple.stackexchange.com/questions/388622/zsh-zprofile-zshrc-zlogin-what-goes-where 
declare -a StringArray=(".xinitrc"  ".gitconfig" ".p10k.zsh" ".tmux.conf" ".zshrc" ".zprofile" ".zlogout" ".zshenv" ".zlogin" ".gpg/gpg-agent" ".ripgreprc")
for DOTFILE in "${StringArray[@]}"; do
      echo -e "\n=>${DOTFILE}::local -> doots"    
    rsync -av --progress  ~/$DOTFILE ~/Documents/dotFiles/$DOTFILE
done
    rsync -av --progress  ~/.config/fish/config.fish ~/Documents/dotFiles/config.fish
    rsync -av --progress  ~/.gnupg/ ~/Documents/dotFiles/.gnupg/*.conf
    rsync -av --progress  ~/.ssh/config ~/Documents/dotFiles/ssh/

# https://stackoverflow.com/questions/4585929/how-to-use-cp-command-to-exclude-a-specific-directory
# of note you can do a dry run using -n

declare -a ConfArray=("lvim" "broot" "tmuxinator" "zellij" "tmux" "kitty" "xmobar" "dunst" "fontconfig" "rg" "qutebrowser" "mimeapps.list")
for CONF in "${ConfArray[@]}"; do
  echo -e "\n=>${CONF}::local -> doots"    
  rsync -av --progress  ~/.config/$CONF ~/Documents/dotFiles/
done
rsync -av --progress ~/.xmonad/ ~/Documents/dotFiles/.xmonad/

#TOOD add ag , wgetrc, curlrc? 
