{ config, pkgs, ... }:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
  home = {
    file = {
      ".config/discord/settings.json".source = "${dotfiles_dir}/.config/discord/settings.json";
    };
    packages = with pkgs; [
      spotify
      spicetify-cli
    ];
  };
}
