{ pkgs, hostname, ... }:
{
  imports = [
    ../../modules/programs/btop.nix
    ../../modules/programs/nnn.nix
    ../../modules/programs/fzf.nix
    ../../modules/programs/kitty.nix
    ../../modules/programs/lazygit.nix
    ../../modules/programs/bat.nix
    ../../modules/programs/rg.nix
    ../../modules/programs/starship.nix
    ../../modules/programs/editors
    ../../modules/programs/modern_unix.nix
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
