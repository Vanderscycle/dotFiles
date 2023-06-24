#!/bin/bash
# in rsync (bash?) if the path is followed by a / it only copies the contents of the directory
declare -a NIX_FOLDERS_PATH=("/etc/nixos" "$HOME/.config/home-manager")
sync(){
    for FOLDER in "${NIX_FOLDERS_PATH}"; do
        rsync -aPv "$FOLDER" .
    done
}

sync