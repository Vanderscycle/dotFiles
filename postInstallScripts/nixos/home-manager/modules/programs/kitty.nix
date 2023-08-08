{ config, pkgs, ... }:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
  # home= {
  #   file = {
  #     ".config/kitty/kitty.conf".source = "${dotfiles_dir}/.config/kitty/kitty.conf";
  #   };
  # };
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
  };
}
