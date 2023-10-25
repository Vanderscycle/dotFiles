{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      lxappearance
    ];
  };

  services.gnome-keyring.enable = true;
  # INFO used for lxappearance dark mode theme
  gtk = {
    enable = true;
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };
    theme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };
    # theme = {
    #   name = "Catppuccin-Mocha";
    #   package = pkgs.catppuccin-gtk;
    # };
    iconTheme = {
      name = "bibata-cursors";
      package = pkgs.bibata-cursors;
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

}
