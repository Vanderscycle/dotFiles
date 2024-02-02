{ pkgs, ... }:
{
  environment.systemPackages = with pkgs;[
    spotify
    discord
    ytfzf
    playerctl
    vlc
  ];
}
