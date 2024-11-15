{
  username,
  home-manager,
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
    programs.firefox = {
      enable = true;
    };
  };
}
