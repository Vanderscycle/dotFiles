{ config, pkgs, ... }:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
  # home= {
  #   file = {
  #     ".config/kitty/kitty.conf".source = "${dotfiles_dir}/.config/kitty/kitty.conf";
  #   };
  # };
  programs = {
    wezterm = {
      enable = true;
      extraConfig = ''
        return {
          -- usemylib = mylib.do_fun();
          -- font = wezterm.font("JetBrains Mono"),
          font_size = 14.0,
          color_scheme = "Catppuccin Mocha", -- or Macchiato, Frappe, Latte
          hide_tab_bar_if_only_one_tab = true,
        }
      '';
    };
    kitty = {
      enable = true;
      theme = "Catppuccin-Mocha";
      shellIntegration.enableFishIntegration = true;
      environment = {
        KITTY_LISTEN_ON="/tmp/mykitty";
      };
      font = {

        size = 14;
        name = "JetBrainsMono";
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
      };
    };
  };
}
