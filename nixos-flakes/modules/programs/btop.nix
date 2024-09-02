{
  username,
  home-manager,
  pkgs,
  ...
}:

# https://home-manager-options.extranix.com/?query=btop&release=master
{
  home-manager.users.${username} = {
    home = { };
    programs.btop = {
      enable = true;
      catppuccin.enable = true;
      settings = {
        theme_background = true;
      };
    };
  };
}
