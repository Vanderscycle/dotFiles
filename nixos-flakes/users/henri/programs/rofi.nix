{
  username,
  home-manager,
  pkgs,
  ...
}:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
  home-manager.users.${username} = {
    home = {
      # file.".config/rofi" = {
      #   source = "${dotfiles_dir}/.config/rofi";
      #   recursive = true;
    };
    packages.rofi = {
      enable = true;
      catppuccin.enable = true;
    };
    # packages = with pkgs; [
    #   rofi
    # ];
  };
}
