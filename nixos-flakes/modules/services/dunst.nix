{
  home-manager,
  username,
  pkgs,
  ...
}:
# https://mynixos.com/home-manager/options/services.dunst
# https://github.com/dunst-project/dunst/wiki/Guides#understanding-rules
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
          # Reference for markup and formatting:
          #  <b>bold</b>
          #  <i>italic</i>
          #  <s>strikethrough</s>
          #  <u>underline</u>
          #  <https://developer.gnome.org/pango/stable/pango-Markup.html>.
          #  %a appname
          #  %s summary
          #  %b body
          #  %i iconname (including its path)
          #  %I iconname (without its path)
          #  %p progress value if set ([  0%] to [100%]) or nothing
          #  %n progress value if set without any extra characters
          #  %% Literal %
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
