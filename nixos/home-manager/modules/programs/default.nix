{ config, pkgs, ... }:

{
  imports = [
    # wm
    ./awesomewm.nix
    # ./polybar.nix
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
    # ./kitty.nix
    ./wezterm.nix
    # cli/gui
    ./modern-unix.nix
    ./devops.nix
    ./btop.nix
    ./discord.nix
    ./zathura.nix
  ];
}
