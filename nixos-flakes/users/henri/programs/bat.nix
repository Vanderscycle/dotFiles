{
  username,
  home-manager,
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
    home = { };
    programs.bat = {
      enable = true;
      catppuccin.enable = true;
    };
  };
}
