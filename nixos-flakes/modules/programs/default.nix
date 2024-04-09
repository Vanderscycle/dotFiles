{ pkgs, home-manager, username, ... }:
{
  imports = [
    ./libreoffice.nix
    ./devops.nix
    ./work.nix
    ./editors
    ./modern_unix.nix
  ];
}
