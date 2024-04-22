{ pkgs, ... }:
{
  imports = [ ./fonts.nix ];
  programs.fish = {
    enable = true;
  };
}
