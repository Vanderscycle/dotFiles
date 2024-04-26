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
    programs.waybar = {
      enable = true;
    };
    home = {
      file = {
        ".config/waybar/config".source = "${dotfiles_dir}/.config/waybar/config";
        ".config/waybar/waybar-wttr.py".source = "${dotfiles_dir}/.config/waybar/waybar-wttr.py";
        ".config/waybar/mocha.css".source = "${dotfiles_dir}/.config/waybar/mocha.css";
        ".config/waybar/style.css".source = "${dotfiles_dir}/.config/waybar/style.css";
      };
    };
  };
}
