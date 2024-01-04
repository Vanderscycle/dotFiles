{ pkgs, ... }:
let
  unstable = import <nixpkgs-unstable> {};
in
{
  nixpkgs.config.packageOverrides = pkgs: {
    orca-slicer = unstable.orca-slicer;
  };
  home = {
    packages = with pkgs; [
      orca-slicer
    ];
  };
}