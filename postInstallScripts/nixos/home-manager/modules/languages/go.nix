{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      # go
      gopls
      delve
    ];
  };
  programs = {
    go = {
      enable = true;
    };
  };
}      
