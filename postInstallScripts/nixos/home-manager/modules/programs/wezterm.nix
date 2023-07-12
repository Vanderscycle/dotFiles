{ config, pkgs, ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      -- Your lua code / config here
      -- local mylib = require 'mylib';
      return {
        -- usemylib = mylib.do_fun();
        font = wezterm.font("JetBrains Mono"),
        font_size = 14.0,
        color_scheme = "Catppuccin Mocha", -- or Macchiato, Frappe, Latte
        hide_tab_bar_if_only_one_tab = true,
      }
    '';
  };
}
