{
  username,
  home-manager,
  pkgs,
  ...
}:
# https://home-manager-options.extranix.com/?query=rofi&release=master
{
  home-manager.users.${username} = {
    home = { };
    programs.rofi = {
      enable = true;
      catppuccin.enable = true;
      font = "JetBrains Nerd Font 12";
      location = "top";
    };
  };
}
