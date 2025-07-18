{
  meta,
  config,
  pkgs,
  ...
}:
{

  imports = [
    # programs
    ../../home-modules/programs
    # languages
    ../../home-modules/languages
    # services
    ../../home-modules/services
  ];
  brave.enable = true;
  fish.enable = true;

  # TODO: medialab shouldn't have my github keyFile
  # find a way to have different keys
  git = {
    userEmail = "henri-vandersleyen@protonmail.com";
    userName = "vanderscycle";
    signingKey = "~/.ssh/endeavourGit.pub";
  };
  keychain.enable = true;
  keychain.keys = [
    "/home/${meta.username}/.ssh/endeavourGit"
  ];
  thunar.enable = true;
  nh.flakeLocation = "/home/${meta.username}/Documents/dotFiles/nix-darwin";
  home = {
    username = meta.username;
    homeDirectory = "/home/${meta.username}";
    stateVersion = "25.05"; # Please read the comment before changing.

    packages = with pkgs; [
      sysz
    ];

    file = { };

    sessionVariables = { };

    sessionPath = [ ];
  };

  catppuccin = {
    flavor = "mocha";
    enable = true;
    mako.enable = false;
  };
}
