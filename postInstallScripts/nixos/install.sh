#!/bin/bash

install() {
	sudo cp -r nixos/configuration.nix /etc/nixos
	mkdir /home/henri/.config/home-manager
	sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
	sudo nix-channel --update
	sudo cp -r home-manager /home/henri/.config/home-manager
	nixos-rebuild switch
}
install
