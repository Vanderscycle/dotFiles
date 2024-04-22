{
  username,
  home-manager,
  pkgs,
  ...
}:

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
