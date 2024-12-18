# home.nix
# home-manager switch
{
  config,
  username,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ../../home-modules/programs
    # languages
    ../../home-modules/languages
    # services
    ../../home-modules/services
  ];

  firefox.enable = false;
  spotify.enable = false;
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
