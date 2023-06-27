{ config, pkgs, ... }:

{
    imports = [
        ./awesomewm.nix
        ./rofi.nix
        ./doomemacs.nix
    ];
}