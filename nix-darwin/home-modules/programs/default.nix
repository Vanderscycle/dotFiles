{ lib, ... }:
{
  imports = [
    ./bat.nix
    ./btop.nix
    ./cloud.nix
    ./cowsay.nix
    #TODO: devops.nix
    ./discord.nix
    ./firefox.nix
    ./fish.nix
    ./fuzzle.nix
    ./fzf.nix
  ];

  fzf.enable = lib.mkDefault true;
  fuzzel.enable = lib.mkDefault false;
  fish.enable = lib.mkDefault false;
  discord.enable = lib.mkDefault false;
  firefox.enable = lib.mkDefault true;
  bat.enable = lib.mkDefault true;
  btop.enable = lib.mkDefault true;
  awscli.enable = lib.mkDefault false;
  linode.enable = lib.mkDefault false;
  cowsay.enable = lib.mkDefault false;
}
