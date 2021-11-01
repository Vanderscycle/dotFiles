{ config, pkgs, lib, ... }:
{
  imports = [
    ./alacritty.nix
    ./tmux.nix
    ./zsh.nix
  ];

   programs = {
    home-manager.enable = true;
    };
   #xsession.enable = true;
   }


