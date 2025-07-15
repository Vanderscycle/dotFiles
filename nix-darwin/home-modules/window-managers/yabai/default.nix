{
  pkgs,
  lib,
  config,
  username,
  ...
}:
{
  options = {
    wm.yabai.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables yabai wm ";
      default = false;
    };

    wm.yabai.configPath = lib.mkOption {
      type = lib.types.path;
      description = "determine the path";
      default = null;
    };
  };

  config = lib.mkIf config.wm.yabai.enable {
    home.file = {
      ".config/yabai".source = /Users/${username}/Documents/dotfiles/.config/yabai;
      ".config/skhd".source = /Users/${username}/Documents/dotfiles/.config/skhd;
    };
  };
}
