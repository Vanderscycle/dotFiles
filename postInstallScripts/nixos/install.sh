#!/bin/bash

install() {
	sudo cp -r nixos/configuration.nix /etc/nixos
	mkdir /home/henri/.config/home-manager
	sudo cp -r home-manager /home/henri/.config/home-manager
	nixos-rebuild switch
}
install
