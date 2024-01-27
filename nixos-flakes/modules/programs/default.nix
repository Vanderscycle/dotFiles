{ pkgs, home-manager, username, ... }:
{
  imports = [
    ./docker
    ./libreoffice
    ./devops
  ];
}
