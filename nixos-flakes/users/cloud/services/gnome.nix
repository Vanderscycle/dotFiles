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
    gtk = {
      enable = true;
      catppuccin.enable = true;
      iconTheme = {
        name = "material-cursors";
        package = pkgs.material-cursors;
      };
      gtk3 = {
        extraConfig = {
          gtk-application-prefer-dark-theme = true;
        };
      };
      gtk4.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
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
