{ config, pkgs, ... }:
{
  programs.btop = {
    enable = true;
    settings = {
      # color_theme = "tokyo-night";
      color_theme = "catppuccin_mocha";
      theme_background = true;
    };
  };
}
    