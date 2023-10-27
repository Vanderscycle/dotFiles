{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # nix programs
    node2nix
    nixpkgs-fmt
    nix-prefetch-git
    # lsp?
    nil
  ];
}
