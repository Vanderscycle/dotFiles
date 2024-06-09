{
  username,
  home-manager,
  pkgs,
  ...
}:
# https://home-manager-options.extranix.com/?query=fzf&release=master
{
  home-manager.users.${username} = {
    home = { };
    programs.fzf = {
      enable = true;
      catppuccin.enable = true;
      enableFishIntegration = true;
    };
  };
}
