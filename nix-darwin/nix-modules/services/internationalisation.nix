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
    # Set your time zone.
    time.timeZone = "America/Vancouver";

    console.useXkbConfig = true;
    i18n = {
      # Select internationalisation properties.
      defaultLocale = "en_CA.UTF-8";
      # defaultLocale = "zh_TW.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };

      inputMethod = {
        enable = true;
        type = "fcitx5";
        uim.toolbar = "gtk"; # gtk-systray
        fcitx5.addons = with pkgs; [
          # fcitx-keyboard-us
          # add:
          fcitx5-rime # pinyin
          qt6Packages.fcitx5-chinese-addons
          qt6Packages.fcitx5-with-addons
          fcitx5-gtk
          # cloudpinyin
        ];
      };
    };

    services.xserver = {
      xkb = {
        layout = "us";
        variant = "";
      };
    };
  };
}
