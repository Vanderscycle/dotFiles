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
    ./fuzzel.nix
    ./fzf.nix
    ./git.nix # TODO: add an option
    ./k9s.nix
    ./kitty.nix
    ./kubernetes.nix
    ./lazygit.nix
    # TODO: keychain.nix
  ];

  # TODO: refactor above like ./git.nix
  kitty.enable = lib.mkDefault true;
  kubernetes.enable = lib.mkDefault false;
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
