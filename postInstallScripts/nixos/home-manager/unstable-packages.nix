{ config, lib, pkgs, ... }:

let
  unstable = import <nixpkgs-unstable> {};
in
{
  nixpkgs.config.packageOverrides = pkgs: {
    waybar-hyprland = unstable.waybar-hyprland;
  };
}
