#!/bin/bash

install(){
    sudo cp -r nixos/configuration.nix /etc/nixos
    sudo cp -r home-manager ~/.config/home-manager
    nixos-rebuild switch
}
install
