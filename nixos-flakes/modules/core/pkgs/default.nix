{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    unzip
    wget
    curl
    firefox
    nixpkgs-fmt
    nix-prefetch-git
    nnn
    xfce.thunar
  ];
}
