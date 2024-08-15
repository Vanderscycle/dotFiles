{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    spotify
    # ytfzf
    playerctl
    vlc
    mpv # like vlc
    wf-recorder # video recorder
  ];
}
