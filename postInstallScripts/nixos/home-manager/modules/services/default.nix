{ config, pkgs, ... }:

{
  imports = [
    ./dunst.nix
    ./git.nix
    ./gnome.nix
    ./dunst.nix
    # window beautifier
    ./picom.nix
    # audio player
    ./playerctl.nix
    ./mpris.nix
    ./mpd.nix
  ];
}
