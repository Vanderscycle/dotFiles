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
    spotify.enable = true;
    gaming = {
      heroic.enable = true;
    };
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
    };

    sessionPath = [ ];
  };

  programs.home-manager.enable = true;
  programs.bash = {
    enable = true;
    # This code runs whenever a bash shell starts
    initExtra = ''
      # If the shell is interactive (not a script) and fish exists, switch to it
      if [[ $- == *i* && -x "$(command -v fish)" ]]; then
        exec fish
      fi
    '';
  };
  programs.fish.enable = true;

  # theme
  catppuccin = {
    flavor = "mocha";
    enable = true;
    mako.enable = false;
  };
}
