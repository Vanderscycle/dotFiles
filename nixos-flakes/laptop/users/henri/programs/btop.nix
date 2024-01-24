{ username, home-manager, pkgs, ... }:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in

{
  home-manager.users.${username} = {
    home = {
      file = {
        # theme
        ".config/btop/themes/catppuccin_mocha.theme".source = "${dotfiles_dir}/.config/bpytop/themes/catppuccin_mocha.theme";
      };
    };
    programs.btop = {
      enable = true;
      settings = {
        # color_theme = "tokyo-night";
        color_theme = "catppuccin_mocha";
        theme_background = true;
      };
    };
  };
}
    
