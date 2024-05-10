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

      file = {
        "/home/henri/SpaceVim.d/init.toml".source = "${dotfiles_dir}/.config/SpaceVim.d/init.toml";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    #lunarvim
    spacevim
  ];
}
