# home.nix
# home-manager switch

{
  config,
  inputs,
  meta,
  pkgs,
  lib,
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
    # wm
    ../../home-modules/window-managers/hyprland
    # bar
    ../../home-modules/status-bars/waybar
  ];

  # TODO: move this to a vm called homelab monolith add factorio, nextcloud
  # services
  dunst.enable = lib.mkForce false;
  fcitx.enable = true; # chinese fonts are super pixels
  gnome.enable = true;
  ssh = {
    enable = true;
    hosts = {
      gitea = {
        hostname = "gitea.homecloud.lan";
        user = "git";
        identityFile = "/home/${meta.username}/.ssh/gitea";
      };
      medialab = {
        hostname = "192.168.1.194";
        user = "medialab";
      };
      monolith = {
        hostname = "192.168.4.129";
        user = "henri";
      };
      macos = {
        hostname = "192.168.4.167";
        user = "mac";
      };
      factorio = {
        hostname = "192.168.4.129";
        user = "monolith";
      };
      knode1 = {
        hostname = "192.168.2.10";
        user = "proxmox";
      };
      knode2 = {
        hostname = "192.168.2.11";
        user = "proxmox";
      };
      knode3 = {
        hostname = "192.168.2.12";
        user = "proxmox";
      };
      livingRoomPi = {
        hostname = "192.168.1.100";
        user = "admin";
      };
    };
  };

  # languages
  languages = {
    go.lsp.enable = true;
    python.lsp.enable = true;
    jsts = {
      vue.enable = false;
      lsp.enable = true;
    };
    latex.lsp.enable = true;
    yaml.lsp.enable = true;
    json.lsp.enable = true;
  };

  # programs
  program = {
    spicetify.enable = false;
    beekeeper.enable = true;
    codium.enable = true;
    bottles.enable = false;
    devops.enable = true;
    flameshot.enable = false; # enabled by hyprland
    brave.enable = true;
    plastic_printer = {
      enable = true;
      orcaslicer.enable = true; # INFO: temp
    };
    thunar.enable = true;
    signal.enable = true;
    zulip.enable = true;
    zathura.enable = true;
    nh.flakeLocation = "/home/${meta.username}/Documents/dotFiles/nix-darwin";
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
    keychain = {
      enable = true;
      keys = [
        "/home/${meta.username}/.ssh/endeavourGit"
        "/home/${meta.username}/.ssh/gitea"
      ];
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

    sessionVariables = { };

    sessionPath = [ ];
  };

  programs.home-manager.enable = true;

  # theme
  catppuccin = {
    flavor = "mocha";
    enable = true;
    mako.enable = false;
  };
}
