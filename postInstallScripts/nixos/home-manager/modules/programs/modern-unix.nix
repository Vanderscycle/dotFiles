{ config, pkgs, ... }:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
    home.packages = with pkgs; [
      fzf
      yq
      jq
      silver-searcher
      httpie
      sysz
      fd
      rsync
      exa
      bat
    ];
    home.file = {
      
      # ripgrep
      ".config/rg/.ripgreprc".source = "${dotfiles_dir}/.config/rg/.ripgreprc";
      # broot
      ".config/broot/conf.hjson".source = "${dotfiles_dir}/.config/broot/conf.hjson";
    };
programs = {
    broot = {
      enable = true;
    };
    };
}
