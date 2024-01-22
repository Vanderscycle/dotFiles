{ pkgs, home-manager, username, ... }:
{
  imports = [
    ./docker
    ./libreoffice
    ./devops
  ];
  environment.systemPackages = with pkgs; [
    docker
  ];
}
