{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # overlays	
      goverlay
      mangohud
      # client
      steam
      heroic
    ];
  };
}
