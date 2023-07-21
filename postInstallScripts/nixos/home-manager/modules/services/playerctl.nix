{ config, pkgs, ... }:
let
  theme = import ../themes;
in

{
  services.playerctld.enable = true;
}
