{ config, pkgs, ... }:

{
  imports = [
    ./python.nix
    ./go.nix
    ./javascript.nix
    ./lua.nix
  ];
}
