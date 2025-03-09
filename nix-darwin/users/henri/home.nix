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
    # wm
    ../../home-modules/window-managers/hyprland
    # bar
    ../../home-modules/status-bars/waybar
  ];

  # services
  dunst.enable = lib.mkForce false;
  fcitx.enable = true; # chinese fonts are super pixels
  gnome.enable = true;
  ssh.enable = true;
  # ssh.authorizedSshKeys = /home/henri/.ssh/endeavourGit; # TODO: move to nix-modules
  # languages
  go.lsp.enable = true;
  python.lsp.enable = true;
  jsts.lsp.enable = true;
  latex.lsp.enable = true;
  yaml.lsp.enable = true;
  json.lsp.enable = true;

  # programs
  flameshot.enable = true;
  brave.enable = true;
  firefox.enable = true; # lib.mkForce false;

  plastic_printer = {
    enable = true;
    orcaslicer.enable = true;
    # bambustudio.enable = true;
    # superslicer.enable = true;
  };
  thunar.enable = true;
  signal.enable = true;
  zulip.enable = true;
  zathura.enable = true;
  nh.flakeLocation = "/home/${username}/Documents/dotFiles/nix-darwin";
  microcontrollers.enable = true;
  office.enable = true;
  kubernetes = {
    enable = true;
    kubeconfig = {
      KUBECONFIG = "$HOME/.kube/homelab-kubeconfig.yaml";
    };
  };
  discord.enable = true;
  fish.enable = true;
  fuzzel.enable = true;
  git = {
    userEmail = "henri-vandersleyen@protonmail.com";
    userName = "vanderscycle";
    signingKey = "~/.ssh/endeavourGit.pub";
  };
  keychain.enable = true;
  keychain.keys = "/home/${username}/.ssh/endeavourGit";
  # cowsay.enable = lib.mkForce true;

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
