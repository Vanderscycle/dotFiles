{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      # go
      gopls
      delve
      # swagger module for gofiber
      go-swag
    ];
  };
  programs = {
    go = {
      enable = true;
    };
  };
}      
