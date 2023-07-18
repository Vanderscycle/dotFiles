{ config, pkgs, ... }:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
  # programs = {
  #   polybar = {
  #     enable = true;
  #   };
  # };
  home = {
    packages = with pkgs; [
      polybar
    ];
    file = {
      ".config/polybar/config.ini".source = "${dotfiles_dir}/.config/polybar/config.ini";
      ".config/polybar/colors.ini".source = "${dotfiles_dir}/.config/polybar/mocha.ini";
    };
  };
}
