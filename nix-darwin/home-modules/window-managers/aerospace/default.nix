{
  pkgs,
  lib,
  config,
  username,
  ...
}:
{
  options = {
    wm.aerospace.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables aerospace wm ";
      default = false;
    };

    wm.aerospace.configPath = lib.mkOption {
      type = lib.types.path;
      description = "determine the path";
      default = null;
    };
  };

  config = lib.mkIf config.wm.aerospace.enable {
    home.file = {
      ".config/aerospace".source = /Users/${username}/Documents/dotfiles/.config/aerospace;
      # config.wm.aerospace.configPath;
    };
  };
}
