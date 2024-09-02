{
  username,
  home-manager,
  pkgs,
  ...
}:
# https://home-manager-options.extranix.com/?query=lazygit&release=master
{
  home-manager.users.${username} = {

    xdg.enable = true;
    home = { };
    programs.lazygit = {
      enable = true;
      catppuccin.enable = true;
    };
  };
}
