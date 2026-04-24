{ ... }:
{
  steppe.program._.fcitx = {
    homeManager =
      { pkgs, ... }:
      {
        home = {
          sessionVariables = {
            # GTK_IM_MODULE = "fcitx";
            # QT_IM_MODULE = "fcitx";
            XMODIFIERS = "@im=fcitx";
            SDL_IM_MODULE = "fcitx";
            DefaultIMModule = "fcitx";
            # GLFW_IM_MODULE = "fcitx5";
            # INPUT_METHOD = "fcitx5";
            # IMSETTINGS_MODULE = "fcitx5";
          };
        };
        i18n.inputMethod = {
          enable = true;
          type = "fcitx5";
          uim.toolbar = "gtk";
          fcitx5 = {
            settings.inputMethod = {
              GroupOrder."0" = "Default";
              "Groups/0" = {
                Name = "Default";
                "Default Layout" = "us";
                DefaultIM = "rime";
              };
              "Groups/0/Items/0".Name = "keyboard-us";
              "Groups/0/Items/1".Name = "rime";
            };
            addons = with pkgs; [
              fcitx5-rime # pinyin
              qt6Packages.fcitx5-chinese-addons
              qt6Packages.fcitx5-with-addons
              fcitx5-gtk
            ];
          };
        };
      };
  };
}
