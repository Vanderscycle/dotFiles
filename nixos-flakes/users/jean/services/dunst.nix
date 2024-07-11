{
  home-manager,
  username,
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
    services.dunst = {
      enable = true;
      catppuccin.enable = true;
      settings = {
        global = {
          geometry = "270x6-24+68";
          transparency = 18;
          padding = 16;
          horizontal_padding = 16;
          corner_radius = 16;
          markup = "full";
          format = "<b>%a</b>\n%s";
          font = "JetBrainsMono 12";
        };
        experimental = {
          per_monitor_dpi = false;
        };
      };
    };
  };
}
