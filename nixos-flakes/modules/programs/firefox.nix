{
  username,
  home-manager,
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
    home = {
      sessionVariables = {
        BROWSER = "firefox";
      };
    };
    programs.firefox = {
      enable = true;
    };
  };
}
