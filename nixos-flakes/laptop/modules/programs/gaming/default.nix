{ pkgs, ... }:
{
  environment.systemPackages = with pkgs;[
    steam
    heroic
  ];
}
