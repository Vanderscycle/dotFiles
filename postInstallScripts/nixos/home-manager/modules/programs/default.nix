{ config, pkgs, ... }:

{
    imports = [
        ./awesomewm.nix
        ./rofi.nix
        ./doomemacs.nix
./fish.nix
./starship.nix
./nnn.nix
./btop.nix
    ];
}