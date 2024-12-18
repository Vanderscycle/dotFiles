# home.nix
# home-manager switch
{
  config,
  username,
  pkgs,
  lib,
  catppuccin,
  ...
}:

{
  imports = [
    ../../home-modules/programs/bat.nix
    ../../home-modules/programs/btop.nix
    ../../home-modules/programs/modern_unix.nix
    ../../home-modules/programs/nnn.nix
    ../../home-modules/programs/fish.nix
    # languages
    ../../home-modules/languages
    # services
    ../../home-modules/services
  ];

  # Makes sense for user specific applications that shouldn't be available system-wide
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
