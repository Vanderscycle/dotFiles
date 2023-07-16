#!/bin/bash
# in rsync (bash?) if the path is followed by a / it only copies the contents of the directory
declare -a NIX_FOLDERS_PATH=("/etc/nixos" "/home/henri/.config/home-manager")

save(){

    for FOLDER in "${NIX_FOLDERS_PATH[@]}"; do
        sudo rsync -av --progress "$FOLDER" "$HOME"/Documents/dotFiles/postInstallScripts/nixos
    done

    #git commit -am "all progress not saved will be lost"
    #git push
    #nixos-rebuildrsync -av --progress "$HOME/.config/home-manager" .
}

save