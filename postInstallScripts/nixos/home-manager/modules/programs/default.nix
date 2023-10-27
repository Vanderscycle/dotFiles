{ config, pkgs, lib, ... }:

let
  base_imports = [
    # wayland wm
    ./hyprland.nix
    ./waybar.nix
    # wm-anciliaries
    ./rofi.nix
    # editor
    ./spacemacs.nix
    ./helix.nix
    ./vscode.nix
    # navigation
    ./nnn.nix
    # dbs
    ./dbs.nix
    # terminal
    ./fish.nix
    ./starship.nix
    ./terminals.nix
    # cli/gui
    ./gaming.nix
    ./modern-unix.nix
    ./devops.nix
    ./btop.nix
    ./discord.nix
    ./zathura.nix
    ./spotify.nix
    # web
    # ./waterfox.nix
  ];
in
{
  imports = base_imports;
}
