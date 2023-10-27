{ config, pkgs, ... }:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
  home.file = {
    # helix
    ".config/helix/config.toml".source = "${dotfiles_dir}/.config/helix/config.toml";
    ".config/helix/languages.toml".source = "${dotfiles_dir}/.config/helix/languages.toml";
  };

    programs = {
      # main
      helix = {
        enable = true;
      };
  };
}
