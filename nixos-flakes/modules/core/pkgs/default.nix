{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    playerctl
    ripgrep
    unzip
    wget
    curl
    firefox
    nixpkgs-fmt
    nix-prefetch-git
    nnn
  ];
}
