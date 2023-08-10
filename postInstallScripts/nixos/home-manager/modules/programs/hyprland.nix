{ config, pkgs, ... }:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
  home = {
    packages = with pkgs; [
      sway
      swww
    ];
    file = {
      ".config/hypr/hyprland.conf".source = "${dotfiles_dir}/.config/hypr/hyprland.conf";
      ".config/hypr/mocha.conf".source = "${dotfiles_dir}/.config/hypr/mocha.conf";
      ".config/hypr/start.sh".source = "${dotfiles_dir}/.config/hypr/start.sh";
    };
  };
}
