{
  username,
  home-manager,
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
    i18n.inputMethod = {
      enabled = "fcitx5";
      uim.toolbar = "gtk";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-rime # pinyin
          fcitx5-chinese-addons
          fcitx5-with-addons
          fcitx5-gtk
        ];
        catppuccin = {
          apply = true; # Ensure the theme is applied
        };
      };
    };
    home = {
      sessionVariables = {
        GTK_IM_MODULE = "fcitx";
        QT_IM_MODULE = "fcitx";
        XMODIFIERS = "@im=fcitx";
        SDL_IM_MODULE = "fcitx";
        # GLFW_IM_MODULE = "fcitx5";
        # INPUT_METHOD = "fcitx5";
        # IMSETTINGS_MODULE = "fcitx5";
      };
    };
  };
}
