#!/bin/bash
# need to find a way to sudo hx and have the same config as the user
# https://github.com/helix-editor/helix/discussions/4251
# works?

install() {
	sudo cp -r nixos/configuration.nix /etc/nixos
	# create folder structures (can nixos handle this instead?)
	mkdir "$HOME"/.config/home-manager
	mkidr "$HOME"/Screenshots
	mkdir -p /mnt/usb /mnt/nas

	sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
	sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
	sudo nix-channel --update

	sudo cp -r home-manager /home/henri/.config/home-manager
	nixos-rebuild switch
}
install
