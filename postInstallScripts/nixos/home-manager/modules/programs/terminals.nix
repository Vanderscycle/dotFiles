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
          use_ime = true,
          xim_im_name = "fcitx",
          font = wezterm.font_with_fallback({
                  { family = "JetBrains Mono", weight = "Regular", italic = false },
          }),          

          font_rules = {
                  {
                          intensity = "Normal",
                          italic = true,
                          font = wezterm.font_with_fallback({
                                  { family = "JetBrains Mono", weight = "Regular", italic = false },
                          }),
                  },
                  {
                          intensity = "Bold",
                          italic = true,
                          font = wezterm.font_with_fallback({
                                  { family = "JetBrains Mono", weight = "Bold", italic = false },
                          }),
                  },
          },
          font_size = 14.0,
          tab_bar_at_bottom = true,
          use_fancy_tab_bar = true,
          enable_tab_bar = true,
          hide_tab_bar_if_only_one_tab = true,
          color_scheme = "Catppuccin Mocha", -- or Macchiato, Frappe, Latte
        }
      '';
    };
    kitty = {
      enable = true;
      theme = "Catppuccin-Mocha";
      shellIntegration.enableFishIntegration = true;
      settings = {
        allow_remote_control = "yes";
        # Add other Kitty settings here if needed
      };      
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
