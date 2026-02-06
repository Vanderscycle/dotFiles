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
  service = {
    fcitx.enable = true;
    sqlite.enable = true;
    swaync.enable = true;
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
          hostname = "192.168.1.196";
          user = "medialab";
        };
        monolith = {
          hostname = "192.168.2.228";
          user = "monolith";
        };
        opencode = {
          hostname = "192.168.2.153";
          user = "opencode";
        };
        steamdeck = {
          hostname = "192.168.1.146";
          user = "deck";
        };
      };
    };
  };

  # languages
  languages = {
    go.lsp.enable = true;
    lua.lsp.enable = true;
    python.lsp.enable = true;
    jsts = {
      lsp.enable = true;
    };
    latex.lsp.enable = true;
    yaml.lsp.enable = true;
    json.lsp.enable = true;
  };

  # programs
  program = {
    vim.enable = true;
    nyxt.enable = true;
    spotify.enable = true;
    spicetify.enable = false;
    godot.enable = false;
    loveGameEngine.enable = true;
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
    opencode.enable = true;
    nh.flakeLocation = "/home/${meta.username}/Documents/dotFiles/nix-darwin";
    microcontrollers.enable = false;
    office.enable = false;
    kubernetes = {
      enable = false;
      kubeconfig = {
        KUBECONFIG = "$HOME/.kube/homelab-kubeconfig.yaml";
      };
    };
    discord.enable = true;
    fish.enable = true;
    fuzzel.enable = true;
    wofi.enable = true;
    git = {
      userEmail = "henri-vandersleyen@protonmail.com";
      userName = "vanderscycle";
      signingKey = "~/.ssh/endeavourGit.pub";
    };
    # INFO: if you have this insane issue where keychain does not work you may have to kill the agent
    # kill <pidfile> 2>/dev/null
    # rm -f $SSH_AUTH_SOCK
    keychain = {
      enableFishIntegration = true;
      enable = true;
      keys = [
        "/home/${meta.username}/.ssh/endeavourGit"
        "/home/${meta.username}/.ssh/gitea"
        "/home/${meta.username}/.ssh/monolith"
      ];
    };
  };

  home = {
    username = meta.username;
    homeDirectory = "/home/${meta.username}";
    stateVersion = "25.05"; # Please read the comment before changing.

    packages = with pkgs; [
      sysz
      wmctrl
    ];

    file = { };

    sessionVariables = {
      PNPM_HOME = "${config.home.homeDirectory}/.local/share/pnpm";
    };

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
