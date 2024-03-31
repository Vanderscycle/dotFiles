{ pkgs, ... }:
{
  environment.systemPackages = with pkgs;[
    spotify
    ytfzf
    playerctl
    vlc
  ];
}
