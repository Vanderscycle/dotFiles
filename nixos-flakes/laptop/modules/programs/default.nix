{ pkgs, home-manager, username, ... }:
{
  imports = [
    ./docker
    ./libreoffice
  ];
  environment.systemPackages = with pkgs; [
    docker
  ];
}
