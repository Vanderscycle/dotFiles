#!/bin/bash

sync() {
	git pull
	sudo rsync -aPv ./configuration.nix /etc/nixos
	nixos-rebuild switch
}
sync