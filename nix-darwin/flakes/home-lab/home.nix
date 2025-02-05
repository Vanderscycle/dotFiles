{ pkgs, username, ... }:
{
  imports = [
    ../../home-modules/programs
    # languages
    ../../home-modules/languages
    # services
    ../../home-modules/services
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
