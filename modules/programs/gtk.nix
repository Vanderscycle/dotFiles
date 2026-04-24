{ ... }:
{
  steppe.gtk = {
    homeManager =
      { pkgs, ... }:
      {
        qt = {
          style = {
            package = pkgs.adwaita-qt;
            name = "adwaita-dark";
          };
        };
        gtk = {
          enable = true;
          theme = {
            name = "Adwaita-dark";
            package = pkgs.gnome-themes-extra;
          };
          gtk3.extraConfig = {
            gtk-application-prefer-dark-theme = true;
          };
          gtk4.extraConfig = {
            gtk-application-prefer-dark-theme = 1;
          };
          cursorTheme = {
            name = "rose-pine-hyprcursor";
            package = pkgs.rose-pine-cursor;
          };
          font = {
            name = "JetBrainsMono";
            package = pkgs.nerd-fonts.jetbrains-mono;
          };
          iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
          };
        };
      };
  };
}
