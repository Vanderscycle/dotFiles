{
  username,
  home-manager,
  pkgs,
  ...
}:
{
  # i18n.inputMethod.fcitx5.catppuccin = true;
  home-manager.users.${username} = {
    home = {
      sessionVariables = {
        GTK_IM_MODULE = "fcitx";
        QT_IM_MODULE = "fcitx";
        XMODIFIERS = "@im=fcitx";
        GLFW_IM_MODULE = "fcitx";
        INPUT_METHOD = "fcitx";
        IMSETTINGS_MODULE = "fcitx";
      };
    };
  };
}
