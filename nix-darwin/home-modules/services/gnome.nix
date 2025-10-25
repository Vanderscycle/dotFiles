{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  options = {
    service.gnome.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables gnome customization";
      default = false;
    };
  };

  config = lib.mkIf config.service.gnome.enable {
    xdg.dataFile."icons/rose-pine-hyprcursor".source = "${
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    }/share/icons/rose-pine-hyprcursor";
    home = {
      packages = with pkgs; [
        # lxappearance
        nwg-look # lxappearance but for wayland
        rose-pine-cursor
      ];
    };

    services.gnome-keyring.enable = true;
    # INFO used for lxappearance dark mode theme
    gtk = {
      enable = true;
      cursorTheme = {
        name = "rose-pine-hyprcursor";
        package = pkgs.rose-pine-cursor;
      };
      font = {
        name = "JetBrainsMono";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };
      gtk3 = {
        extraConfig = {
          gtk-application-prefer-dark-theme = true;
        };
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
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
