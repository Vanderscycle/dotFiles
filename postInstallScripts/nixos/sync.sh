#!/bin/bash

sync() {
  git pull
	sudo rsync -aPv "$HOME"/Documents/dotFiles/nixos/configuration.nix /etc/nixos
  sudo rsync -aPv "$HOME"/Documents/dotFiles/home-manager "$HOME"/.config/home-manager
	nixos-rebuild switch
}
sync