{
  home-manager,
  username,
  pkgs,
  ...
}:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [ dunst ];
      file = {
        ".config/dunst/dunstrc".source = "${dotfiles_dir}/.config/dunst/dunstrc";
      };
    };
  };
}
