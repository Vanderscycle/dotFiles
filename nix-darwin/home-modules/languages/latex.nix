{ pkgs, ... }:
{
  home.packages = with pkgs; [
    texliveFull # latex client
  ];
}
