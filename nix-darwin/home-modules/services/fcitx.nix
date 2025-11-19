{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    service.fcitx.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables fcitx languages";
      default = false;
    };
  };

  # search under cn in fctix5-configtool
  # {slack/discord/steam} --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime
  config = lib.mkIf config.service.fcitx.enable {

    catppuccin.fcitx5.apply = true; # Ensure the theme is applied
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      uim.toolbar = "gtk";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-rime # pinyin
          qt6Packages.fcitx5-chinese-addons
          qt6Packages.fcitx5-with-addons
          fcitx5-gtk
        ];
      };
    };
    home = {
      sessionVariables = {
        GTK_IM_MODULE = "fcitx";
        QT_IM_MODULE = "fcitx";
        XMODIFIERS = "@im=fcitx";
        SDL_IM_MODULE = "fcitx";
        DefaultIMModule = "fcitx";
        # GLFW_IM_MODULE = "fcitx5";
        # INPUT_METHOD = "fcitx5";
        # IMSETTINGS_MODULE = "fcitx5";
      };
    };
  };
}
