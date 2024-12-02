{ pkgs, ... }:
# https://home-manager-options.extranix.com/?query=btop&release=master
{
  programs.btop = {
    enable = true;
    catppuccin.enable = true;
    settings = {
      theme_background = true;
    };
  };
}
