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
      fcitx5 = {
        catppuccin = {
          apply = true; # Ensure the theme is applied
        };
      };
    };
    home = {
      sessionVariables = {
        # GTK_IM_MODULE = "fcitx5";
        # QT_IM_MODULE = "fcitx5";
        # XMODIFIERS = "@im=fcitx5";
        #  GLFW_IM_MODULE = "fcitx5";
        INPUT_METHOD = "fcitx5";
        IMSETTINGS_MODULE = "fcitx5";
      };
    };
  };
}
