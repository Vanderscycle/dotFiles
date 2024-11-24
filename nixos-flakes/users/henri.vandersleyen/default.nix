{ pkgs, username, ... }:
{
  imports = [
    ./programs.nix
    ./services.nix
    ./languages.nix
  ];

  nix = {
    nixPath = [ "nixpkgs=/run/current-system/nixpkgs" ];
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
