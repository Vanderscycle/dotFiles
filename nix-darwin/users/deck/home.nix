{
  config,
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
    brave.enable = true;
    nh.flakeLocation = "/home/${meta.username}/Documents/dotFiles/nix-darwin";
    git = {
      userEmail = "henri-vandersleyen@protonmail.com";
      userName = "vanderscycle";
      signingKey = "~/.ssh/endeavourGit.pub";
    };
  };

  home = {
    username = meta.username;
    homeDirectory = "/home/${meta.username}";
    stateVersion = "25.05"; # Please read the comment before changing.

    packages = with pkgs; [
      sysz
    ];

    file = { };

    sessionVariables = {
      PNPM_HOME = "${config.home.homeDirectory}/.local/share/pnpm";
    };

    sessionPath = [ ];
  };

  programs.home-manager.enable = true;
  programs.fish.enable = true;

  # theme
  catppuccin = {
    flavor = "mocha";
    enable = true;
    mako.enable = false;
  };
}
