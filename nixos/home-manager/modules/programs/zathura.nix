{ config, pkgs, ... }:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
  home = {
    file = {
      ".config/zathura/zathurarc".source = "${dotfiles_dir}/.config/zathura/zathurarc";
      ".config/zathura/catppuccin-mocha".source = "${dotfiles_dir}/.config/zathura/catppuccin-mocha";
    };
    packages = with pkgs; [
      zathura
    ];
  };
  # programs = {
  #   zathura = {
  #     enable = true;
  #     options = {
  #       selection-clipboard = "clipboard";
  #     };
  #   };
  # };
}
