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
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done

declare -a HomeArray=(".xinitrc"  ".gitconfig" ".gitconfig.personal" ".gpg/gpg-agent" ".ripgreprc" "zettelkasten" ".gnupg" ".ssh/config" "zettelkasten" ".xmonad")

declare -a ConfArray=("lvim" "broot" "zellij" "kitty" "xmobar" "dunst" "fontconfig" "rg" "mimeapps.list" "bat" "rg" "neofetch" "picom" "k9s" "fish/config.fish" "bpytop")

sync(){
  echo -e "sync"
  for DOTFILE in "${HomeArray[@]}"; do
      echo -e "\n=>${DOTFILE}::doots -> local"    
      rsync -av --progress   ~/Documents/dotFiles/.config/ ~/"$DOTFILE"
  done

  for DOTFILE in "${ConfArray[@]}"; do
      echo -e "\n=>${DOTFILE}::doots -> local"    
      rsync -av --progress   ~/Documents/dotFiles/.config/ ~/.config/"$DOTFILE"
  done

  rsync -av --progress   ~/Documents/dotFiles/etc/fstab /etc/fstab
  sudo rsync -av --progress  ~/Documents/dotFiles/pacman.conf /etc/pacman.conf 
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
  rsync -av --progress /etc/default/grub ~/Documents/dotFiles/
  rsync -av --progress /etc/pacman.conf ~/Documents/dotFiles/pacman.conf
  lvim +PackerSync +qall
}

main(){
  if [[ "$CMD" == 'save' ]]; then
    save
  elif [[ "$CMD" == 'sync' ]]; then
    sync
  fi
}
main

