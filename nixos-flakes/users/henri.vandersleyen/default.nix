{ pkgs, username, ... }:
{
  imports = [
    ./programs.nix
    ./services.nix
    ./languages.nix
  ];
}
