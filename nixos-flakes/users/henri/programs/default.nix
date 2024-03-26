{ pkgs, ... }:
{
  imports = [
    ./btop.nix
    ./screenshot.nix
    ./keyboard.nix
    ./keychain.nix
    ./nnn.nix
    ./transmission.nix
    ./rofi.nix
    ./printer.nix
    ./plastic_printer.nix
  ];

  # ----------------------
  # default applications
  # ---------------------  
  xdg.mimeApps = {
    defaultApplications = {
      "application/pdf" = [ "zathura.desktop" ];
      "application/json" = [ "vim.desktop" ]; # You'll need a .desktop file for Vim or your preferred editor
    };
  };
}
