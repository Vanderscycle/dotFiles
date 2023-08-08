{ config, pkgs, lib, ... }:

let 
 base_imports = [
    # x wm
    # ./awesomewm.nix
    # wayland wm
    ./hyprland.nix
    ./waybar.nix
    # wm-anciliaries
    ./rofi.nix
    # editor
    ./doomemacs.nix
    ./nyoom.nix
    ./helix.nix
    # navigation
    ./nnn.nix
    # terminal
    ./fish.nix
    ./starship.nix
    ./kitty.nix
    ./wezterm.nix
    # cli/gui
    ./gaming.nix
    ./modern-unix.nix
    ./devops.nix
    ./btop.nix
    ./discord.nix
    ./spotify.nix
    ./zathura.nix
 ];
in
{
  imports =  base_imports;
}