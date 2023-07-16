#!/bin/bash

sync() {
  git pull
	sudo rsync -aPv "$HOME"/Documents/dotFiles/postInstallScripts/nixos/configuration.nix /etc/nixos
  sudo rsync -aPv "$HOME"/Documents/dotFiles/postInstallScripts/nixos/home-manager "$HOME"/.config/home-manager
	nixos-rebuild switch
}
sync