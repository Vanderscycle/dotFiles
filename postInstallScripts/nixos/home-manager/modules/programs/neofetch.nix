{ config, pkgs, ... }:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
  home = {
    file = {
      # neofetch
      ".config/neofetch/config.conf".source = "${dotfiles_dir}/.config/neofetch/config.conf";
    };

    packages = with pkgs; [
      neofetch # show that nixos symbol
    ];
  };
}
    