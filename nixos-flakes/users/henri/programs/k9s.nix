{
  username,
  home-manager,
  pkgs,
  ...
}:
# https://home-manager-options.extranix.com/?query=k9s&release=master
{
  home-manager.users.${username} = {
    home = {
      programs.k9s = {
        enable = true;
        catppuccin.enable = true;
      };
    };
  };
}
