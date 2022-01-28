#!/bin/bash

declare -a StringArray=( ".xinitrc" ".gitconfig" ".p10k.zsh" ".tmux.conf" ".zshrc" ".zprofile" ".zlogout" ".zshenv" ".zlogin" ".gpg/gpg-agent")
for DOTFILE in "${StringArray[@]}"; do
    # can't use symbolic link since we want the file
    # echo "~/Documents/dotFiles/$DOTFILE" ~/$DOTFILE
    rsync -av  --progress ~/Documents/dotFiles/$DOTFILE ~/$DOTFILE
done

rg --passthru 'henri' -r $DOOTS_USER_NAME ~/.zshrc > ~/.temp.txt && mv ~/.temp.txt ~/.zshrc.sh

declare -a ConfArray=("lvim","fish","broot","tmuxinator","zellij","tmux", "kitty", "xmobar", "dunst","fontconfig")
for CONF in "${ConfArray[@]}"; do
  echo -e "\n=>${CONF}::local -> doots"    
  rsync -auv --progress ~/Documents/dotFiles/$CONF  ~/.config/$CONF
done
rsync -av --progress ~/Documents/dotFiles/.xmonad/ ~/.xmonad/

# rsync -av --progress  ~/.xmonad/ ~/Documents/dotFiles/.xmonad/
# rsync -av --progress  ~/Documents/dotFiles/lvim/ ~/.config/lvim/
# rsync -av --progress  ~/Documents/dotFiles/fish/ ~/.config/fish/
# rsync -av --progress  ~/Documents/dotFiles/broot/ ~/.config/broot/
# rsync -av --progress  ~/Documents/dotFiles/tmuxinator/ ~/.config/tmuxinator/ 
# rsync -av --progress  ~/Documents/dotFiles/zellij/ ~/.config/zellij/
# rsync -av --progress  ~/Documents/dotFiles/tmux/ ~/.config/tmux/
# rsync -av --progress ~/Documents/dotFiles/kitty/ ~/.config/kitty/
# rsync -av --progress ~/Documents/dotFiles/xmobar/ ~/.config/xmobar/
# rsync -av --progress ~/Documents/dotfiles/dunst/ ~/.config/dunst/ 
# rsync -av --progress  ~/Documents/dotFiles/fontconfig/ ~/.config/fontconfig/


lvim +PackerSync +qall
# lvim +LspInstall svelte tsserver tailwindcss +qall


# lvim 
# maybe combine both bash files into a single on
