{
  home-manager,
  username,
  pkgs,
  ...
}:
let
  dotfiles_dir = /home/${username}/Documents/dotFiles;
in
{
  home-manager.users.${username} = {
    home = {
      file = {
        "/home/${username}/SpaceVim.d/init.toml".source = "${dotfiles_dir}/.config/SpaceVim.d/init.toml";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    lunarvim
    # spacevim
  ];
}
