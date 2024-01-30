{pkgs, ...}:
{
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
      enabled = "fcitx5";
      uim.toolbar = "gtk"; # gtk-systray
      fcitx5.addons = with pkgs; [
        # fcitx-keyboard-us
        # add:
        fcitx5-rime # pinyin
        fcitx5-chinese-addons
        fcitx5-with-addons
        fcitx5-gtk
        # cloudpinyin
      ];
    };
  };

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
}

