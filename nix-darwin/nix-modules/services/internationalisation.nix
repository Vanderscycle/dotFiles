{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    internationalisation.enable = lib.mkOption {
      type = lib.types.bool;
      description = "enables multilanguage support";
      default = false;
    };
  };

  config = lib.mkIf config.internationalisation.enable {
    time.timeZone = "America/Vancouver";

    services.xserver.xkb = {
      layout = "us,ca"; # First is default (EN), second is FR
      variant = "";
      # options = "grp:alt_shift_toggle"; # Shortcut to switch
    };

    console.useXkbConfig = true;
    i18n = {
      defaultLocale = "en_CA.UTF-8"; # Use "fr_CA.UTF-8" if you want menus in French
      extraLocaleSettings = {
        LC_ADDRESS = "en_CA.UTF-8";
        LC_IDENTIFICATION = "en_CA.UTF-8";
        LC_MEASUREMENT = "en_CA.UTF-8";
        LC_MONETARY = "en_CA.UTF-8";
        LC_NAME = "en_CA.UTF-8";
        LC_NUMERIC = "en_CA.UTF-8";
        LC_PAPER = "en_CA.UTF-8";
        LC_TELEPHONE = "en_CA.UTF-8";
        LC_TIME = "en_CA.UTF-8";
      };

      inputMethod = {
        enable = true;
        type = "fcitx5";
        uim.toolbar = "gtk";
        fcitx5.addons = with pkgs; [
          fcitx5-rime # pinyin
          qt6Packages.fcitx5-chinese-addons
          qt6Packages.fcitx5-with-addons
          fcitx5-gtk
        ];
      };
    };

  };
}
