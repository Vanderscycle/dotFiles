# home.nix
# home-manager switch

{
  config,
  meta,
  pkgs,
  ...
}:

{
  imports = [

    # programs
    ../../home-modules/programs/arc_browser.nix
    ../../home-modules/programs/direnv.nix
    ../../home-modules/programs/nnn.nix
    ../../home-modules/programs/kitty.nix
    ../../home-modules/programs/starship.nix
    ../../home-modules/programs/lazygit.nix
    ../../home-modules/programs/modern_unix.nix
    ../../home-modules/programs/fzf.nix
    # ../../home-modules/programs/ghostty.nix # INFO:broken
    ../../home-modules/programs/btop.nix
    ../../home-modules/programs/cloud.nix
    ../../home-modules/programs/codium.nix
    ../../home-modules/programs/fish.nix
    ../../home-modules/programs/zsh.nix
    ../../home-modules/programs/nushell.nix
    ../../home-modules/programs/keychain.nix
    ../../home-modules/programs/spacemacs.nix
    ../../home-modules/programs/git.nix
    ../../home-modules/programs/vim.nix
    ../../home-modules/programs/devops.nix
    ../../home-modules/programs/spotify.nix
    ../../home-modules/programs/nh.nix
    ../../home-modules/programs/bat.nix
    ../../home-modules/programs/codium.nix

    # languages
    ../../home-modules/languages/nix.nix
    ../../home-modules/languages/python.nix
    ../../home-modules/languages/jsts.nix
    ../../home-modules/languages/bash.nix
    ../../home-modules/languages/json.nix
    ../../home-modules/languages/yaml.nix

    # services
    # ./home-modules/services/appleTouchId.nix

    # secrets (home-manager)
    ./sops.nix
  ];

  # languages
  languages = {
    python.lsp.enable = false;
    jsts.lsp.enable = true;
    yaml.lsp.enable = true;
    json.lsp.enable = true;
  };

  # programs
  program = {
    vim.enable = true;
    direnv.enable = true;
    awscli.enable = false; # brew
    arc-browser.enable = false; # brew
    codium.enable = false;
    fish.enable = false;
    zsh.enable = true;
    nh.flakeLocation = "/Users/${meta.username}/Documents/dotFiles/nix-darwin";
    keychain = {
      enable = true;
      keys = [ "/home/${meta.username}/.ssh/knak" ];
    };
    git = {
      # userEmail = config.sops.secrets."knak/email".path;
      userEmail = "henri.vandersleyen@knak.com";
      # userName = config.sops.secrets."knak/git/userName".path;
      userName = "vancycles-knak";
      signingKey = config.sops.secrets."knak/git/keyName".path;
    };
  };
  fonts.fontconfig.enable = true;
  home = {
    username = meta.username;
    homeDirectory = "/Users/${meta.username}";
    stateVersion = "23.05"; # Please read the comment before changing.

    # Makes sense for user specific applications that shouldn't be available system-wide
    # packages = with pkgs; [
    # ];

    file = { };

    sessionVariables = { };

    sessionPath = [
      "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
    ];
  };

  programs.home-manager.enable = true;

  # theme
  catppuccin = {
    flavor = "mocha";
    enable = true;
    mako.enable = false;
  };
}
