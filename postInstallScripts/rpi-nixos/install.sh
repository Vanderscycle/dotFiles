#!/bin/bash

install() {
	cp -r ./configuration.nix /etc/nixos
	nixos-rebuild switch
}
install
