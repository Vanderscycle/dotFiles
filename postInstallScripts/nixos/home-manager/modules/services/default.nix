{ config, pkgs, ... }:

{
  imports = [
    ./dunst.nix
    ./git.nix
    ./gnome.nix
    ./autorandr.nix #working?
    # window beautifier
    ./picom.nix
    # audio player
    ./playerctl.nix
    ./mpris.nix
  ];
}
