#!/bin/bash

declare -a NIX_FOLDERS_PATH=("/etc/nixos/" "$HOME/.config/home-manger/")
sync(){
    for FOLDER in "${NIX_FOLDERS_PATH}"; do
        rsync -av --progress --dry-run "$FOLDER" "$HOME/Documents/dotFiles"
    done
    echo -e "sync"
    rsync

}

sync