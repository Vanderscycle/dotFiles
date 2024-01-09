{ config, pkgs, ... }:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
  home.packages = with pkgs; [
    fzf
    ytfzf
    yq
    jq
    silver-searcher
    httpie
    sysz
    fd
    rsync
    eza
    bat
    ripgrep
    tree # that old school tree feel
  ];
  home.file = {
    # bat
    ".config/bat/config".source = "${dotfiles_dir}/.config/bat/config";
    ".config/bat/themes/Catppuccin-mocha.tmTheme".source = "${dotfiles_dir}/.config/bat/themes/Catppuccin-mocha.tmTheme";
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
