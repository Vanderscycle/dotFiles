{ config, pkgs, ... }:

{
  imports = [
    ./python.nix
    ./go.nix
  ];
}
