{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.flameshot
  ];
}
