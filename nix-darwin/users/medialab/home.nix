{
  meta,
  pkgs,
  ...
}:
{

  imports = [
    # programs
    ../../home-modules/programs
    # languages
    ../../home-modules/languages
  ];

  # programs
  program = {
    spotify.enable = false;
    proton.enable = true;
    brave.enable = true;
    fish.enable = true;
    keychain = {
      enable = true;
      keys = [
        "/home/${meta.username}/.ssh/endeavourGit"
      ];
    };
    thunar.enable = true;
    nh.flakeLocation = "/home/${meta.username}/Documents/dotFiles/nix-darwin";
  };

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
