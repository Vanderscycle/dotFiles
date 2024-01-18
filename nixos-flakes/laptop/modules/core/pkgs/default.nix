{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gh
    playerctl
    ripgrep
    unzip
    wget
    curl
    firefox
    nixpkgs-fmt
  ];
}
