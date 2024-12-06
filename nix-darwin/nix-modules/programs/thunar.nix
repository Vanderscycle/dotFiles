{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    xfce.thunar # not unix but a really good
    xfce.tumbler
  ];
}
