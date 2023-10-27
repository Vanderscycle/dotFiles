{ config, pkgs, ... }:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
  home = {
    file = {
      ".config/spicetify/config-xpui.ini".source = "${dotfiles_dir}/.config/spicetify/config-xpui.ini";
    };
    packages = with pkgs; [
      spotify
      # spicetify-cli
    ];
  };
}

# spicetify is a pain in the rear to make it work on nixos
# best is to create a mutable 
# realpath ${which spotify}
# mkdir ~/.config/mutable_spotify 
# cp -r <store path> ~/.config/mutable_spotify