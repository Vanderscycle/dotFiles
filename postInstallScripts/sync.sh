#!/bin/bash
CMD=""

# ArgParse
while (( "$#" )); do
  case "$1" in
    -c|--command)
      if [ -n "$2" ] && [ "${2:0:1}" != "-" ]; then
        CMD=$2
        shift 2
      else
        echo "Error: Argument for $1 is missing" >&2
        exit 1
      fi
      ;;
    -*)# unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done

declare -a HomeArray=(".xinitrc"  ".gitconfig" ".gitconfig.personal" ".gpg/gpg-agent" ".ripgreprc" "zettelkasten" ".ssh/config" "zettelkasten" ".xmonad" ".wezterm" ".doom.d")

declare -a ConfArray=("broot" "zellij" "rofi" "kitty" "xmobar" "dunst" "fontconfig" "rg" "BetterDiscord" "mimeapps.list" "bat" "rg" "neofetch" "picom" "k9s" "fish/config.fish" "bpytop" "starship.toml" "awesome"  "emacs/.local/etc/bookmarks")

sync(){
  echo -e "sync"
  for DOTFILE in "${HomeArray[@]}"; do
      echo -e "\n=>${DOTFILE}::doots -> local"
      rsync -av --progress   ~/Documents/dotFiles/"$DOTFILE"
  done

  for DOTFILE in "${ConfArray[@]}"; do
      echo -e "\n=>${DOTFILE}::doots -> local"
      rsync -av --progress   ~/Documents/dotFiles/.config/"$DOTFILE" ~/.config/
  done

  rsync -av --progress   ~/Documents/dotFiles/etc/fstab /etc/fstab
  rsync -av --progress  ~/Documents/dotFiles/etc/resolv.conf /etc/resolvconf
  rsync -av --progress  ~/Documents/dotFiles/ /etc/default/grub
  sudo rsync -av --progress  ~/Documents/dotFiles/pacman.conf /etc/pacman.conf

  lvim +PackerSync +qall
}

save(){
  echo -e "save"
  for DOTFILE in "${HomeArray[@]}"; do
      echo -e "\n=>${DOTFILE}::local -> doots"
      rsync -av --progress  ~/"$DOTFILE" ~/Documents/dotFiles/

  done
  for DOTFILE in "${ConfArray[@]}"; do
      echo -e "\n=>${DOTFILE}::local -> doots"
      rsync -av --progress ~/.config/"$DOTFILE" ~/Documents/dotFiles/.config/
  done
  rsync -av --progress /etc/fstab ~/Documents/dotFiles/etc/fstab
  rsync -av --progress /etc/resolv.conf ~/Documents/dotFiles/etc/resolv.conf
  rsync -av --progress /etc/default/grub ~/Documents/dotFiles/
  sudo rsync -av --progress /etc/pacman.conf ~/Documents/dotFiles/pacman.conf
}

main(){
  if [[ "$CMD" == 'save' ]]; then
    save
  elif [[ "$CMD" == 'sync' ]]; then
    sync
  fi
}
main
