# home.nix
# home-manager switch

{
  config,
  username,
  pkgs,
  ...
}:

{
  imports = [

    # programs
    ../../home-modules/programs/nnn.nix
    ../../home-modules/programs/kitty.nix
    ../../home-modules/programs/starship.nix
    ../../home-modules/programs/lazygit.nix
    ../../home-modules/programs/modern_unix.nix
    ../../home-modules/programs/fzf.nix
    # ../../home-modules/programs/ghostty.nix # INFO:broken
    ../../home-modules/programs/btop.nix
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

    # languages
    ../../home-modules/languages/nix.nix
    ../../home-modules/languages/python.nix
    ../../home-modules/languages/jsts.nix
    ../../home-modules/languages/bash.nix

    # services
    # ./home-modules/services/appleTouchId.nix

    # Window-manager
    ../../home-modules/window-managers/aerospace

    # starus-bars
    # ../../home-modules/status-bars/sketchybar

    # secrets (home-manager)
    ./sops.nix
  ];

  # wm
  wm.aerospace = {
    enable = false;
    configPath = Users/${username}/Documents/dotfiles/.config/aerospace;
  };
  # languages
  python.lsp.enable = true;
  jsts.lsp.enable = true;

  # programs
  fish.enable = true;
  zsh.enable = true;
  nh.flakeLocation = "/Users/${username}/Documents/dotFiles/nix-darwin";
  keychain.enable = true;
  keychain.keys = "/home/henri/.ssh/knak";

  git = {
    # userEmail = config.sops.secrets."knak/email".path;
    userEmail = "henri.vandersleyen@knak.com";
    # userName = config.sops.secrets."knak/git/userName".path;
    userName = "vancycles-knak";
    signingKey = config.sops.secrets."knak/git/keyName".path;
  };

  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "23.05"; # Please read the comment before changing.

    # Makes sense for user specific applications that shouldn't be available system-wide
    packages = [ ];

    file = { };

    sessionVariables = { };

    sessionPath = [
      "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
    ];
  };

  programs.home-manager.enable = true;

  # theme
  catppuccin.flavor = "mocha";
  catppuccin.enable = true;
}
