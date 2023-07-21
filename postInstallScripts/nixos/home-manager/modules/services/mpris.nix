{ config, pkgs, ... }:
let
  theme = import ../themes;
in

{
  services.mpd-mpris.enable = true;
}

