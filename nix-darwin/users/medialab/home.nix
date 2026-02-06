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
    # services
    ../../home-modules/services
  ];
  program = {
    vim.enable = true;
    spotify.enable = false;
    spicetify.enable = false;
    proton.enable = true;
    brave.enable = true;
    fish.enable = true;
    git = {
      userEmail = "henri-vandersleyen@protonmail.com";
      userName = "vanderscycle";
      signingKey = "~/.ssh/endeavourGit.pub";
    };
    keychain = {
      enable = true;
      keys = [
        "/home/${meta.username}/.ssh/endeavourGit"
      ];
    };
    thunar.enable = true;
    nh.flakeLocation = "/home/${meta.username}/Documents/dotFiles/nix-darwin#medialab";
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
