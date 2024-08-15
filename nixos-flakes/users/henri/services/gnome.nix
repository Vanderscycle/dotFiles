{
  home-manager,
  username,
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [ lxappearance ];
    };

    services.gnome-keyring.enable = true;
    # INFO used for lxappearance dark mode theme
    gtk = {
      enable = true;
      # iconTheme = {
      #   name = "bibata-cursors";
      #   package = pkgs.bibata-cursors;
      # };
      iconTheme = {
        name = "material-cursors";
        package = pkgs.material-cursors;
      };
      gtk3 = {
        extraConfig = {
          gtk-application-prefer-dark-theme = true;
          gtk-im-module = "fcitx";
        };
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
        gtk-im-module = "fcitx";
      };
    };
    qt = {
      style = {
        package = pkgs.adwaita-qt;
        name = "adwaita-dark";
      };
    };
  };
}
