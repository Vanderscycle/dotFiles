{ pkgs, username, ... }:
{

  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [ lxappearance ];
    };

    dconf = {
      enable = true;
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };
    # INFO used for lxappearance dark mode theme
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
  services.xserver = {
    enable = true;
    displayManager = {
      autoLogin.enable = true;
      autoLogin.user = "account";
      gdm.enable = true;
    };
    desktopManager.gnome.enable = true;
  };
  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-photos
      gnome-tour
    ])
    ++ (with pkgs.gnome; [
      gnome-music
      epiphany # web browser
      gnome-characters
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ])
    ++ (with pkgs; [
      cheese # webcam tool
      pkgs.gedit # text editor
      gnome-terminal
      geary # email reader
      evince # document viewer
      totem # video player
    ]);
}
