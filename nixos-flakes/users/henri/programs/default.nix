{ pkgs, ... }:
{
  imports = [
    ./btop.nix
    ./flameshot.nix
    ./keyboard.nix
    ./keychain.nix
    ./nnn.nix
    ./transmission.nix
  ];

  # ----------------------
  # default applications
  # ---------------------  
  # xdg.mimeApps.defaultApplications = {
  #   "text/html" = [ "firefox.desktop" ];
  #   "x-scheme-handler/http" = [ "firefox.desktop" ];
  #   "x-scheme-handler/https" = [ "firefox.desktop" ];
  #   "x-scheme-handler/about" = [ "firefox.desktop" ];
  #   "image/png" = [ "shotwell.desktop" ];
  #   "image/jpeg" = [ "shotwell.desktop" ];
  #   "application/pdf" = [ "zathura.desktop" ];
  # };
}
