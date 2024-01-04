{ config, pkgs, theme, ... }:

let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
  home = {

    packages = with pkgs; [
      dunst
    ];
    file = {
      ".config/dunst/dunstrc".source = "${dotfiles_dir}/.config/dunst/dunstrc";
    };
  };
}
