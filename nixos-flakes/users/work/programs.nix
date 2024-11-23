{ pkgs, hostname, ... }:
{
  imports = [
    ../../modules/programs/btop.nix
    ../../modules/programs/nnn.nix
    ../../modules/programs/fzf.nix
    ../../modules/programs/kitty.nix
    ../../modules/programs/lazygit.nix
    ../../modules/programs/starship.nix
    ../../modules/programs/bat.nix
    ../../modules/programs/rg.nix
    ../../modules/programs/starship.nix
  ];
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = { };
    casks = [ ];
    taps = [ ];
    brews = [ ];
  };
}
