{ config, pkgs, ... }:

{
  imports = [
    ./dunst.nix
    ./git.nix
    ./gnome.nix
    ./autorandr.nix
    ./picom.nix
  ];
}
