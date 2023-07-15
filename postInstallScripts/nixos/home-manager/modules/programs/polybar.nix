{ config, pkgs, ... }:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
  programs = {
    polybar = {
      enable = true;
    };
  };
  # home = {
  #   packages = with pkgs; [
  #   ];
  #   file = {
  #     ".config/k9s/config.yml".source = "${dotfiles_dir}/.config/k9s/config.yml";
  #   };
  # };
}
