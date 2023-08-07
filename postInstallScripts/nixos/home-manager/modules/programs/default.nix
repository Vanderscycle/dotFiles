{ config, pkgs, ... }:

{
  imports = [
    # wm
    # TODO: must disable them in the workstation.
    ./awesomewm.nix
    ./polybar.nix
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
    ./gaming.nix
    ./modern-unix.nix
    ./devops.nix
    ./btop.nix
    ./discord.nix
    ./spotify.nix
    ./zathura.nix
  ];
}
