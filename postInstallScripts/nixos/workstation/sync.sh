#!/bin/bash

sync() {
	sudo rsync -aPv ./configuration.nix /etc/nixos
	nixos-rebuild switch
}
sync