{ pkgs, username, ... }:
{
  imports = [
    # programs
    ../../home-modules/programs/nnn.nix
    ../../home-modules/programs/lazygit.nix
    ../../home-modules/programs/modern_unix.nix
    ../../home-modules/programs/fzf.nix
    ../../home-modules/programs/btop.nix
    ../../home-modules/programs/fish.nix
    ../../home-modules/programs/keychain.nix
    ../../home-modules/programs/git.nix
    ../../home-modules/programs/vim.nix
    ../../home-modules/programs/nh.nix
    # languages
    ../../home-modules/languages/nix.nix
    ../../home-modules/languages/bash.nix
    # services
  ];
  nh.flakeLocation = "/home/${username}/Documents/dotFiles/nix-darwin/flakes/home-lab";

  git = {
    userEmail = "henri-vandersleyen@protonmail.com";
    userName = "vanderscycle";
    signingKey = "~/.ssh/endeavourGit.pub";
  };

  keychain.enable = true;
  keychain.keys = "/home/henri/.ssh/endeavourGit";

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05"; # Please read the comment before changing.

    packages = with pkgs; [
      sysz
    ];

    file = { };

    sessionVariables = { };

    sessionPath = [ ];
  };

  programs.home-manager.enable = true;

  # theme
  catppuccin.flavor = "mocha";
  catppuccin.enable = true;
}
