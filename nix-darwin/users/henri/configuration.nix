{
  pkgs,
  inputs,
  meta,
  hosts,
  ...
}:
{
  imports = [
    hosts.nixosModule
    ../../hosts
    # hardware related e.g. keyboards
    ../../nix-modules/hardware
    # scripts
    ../../nix-modules/writerScripts
    # docker containers
    ../../nix-modules/containers
    # programs
    ../../nix-modules/programs
    # services
    ../../nix-modules/services
    # systemd/cron
    ../../nix-modules/cron
    # local
    ./sops.nix
  ];

  system.stateVersion = "25.05";
  boot.extraModprobeConfig = ''options bluetooth disable_ertm=1 '';

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    lua-language-server
  ];
  # containers
  container = {
    lute.enable = true;
  };
  # scripts
  script = {
    emacs.enable = true;
  };
  # cron
  cron = {
    nasBackup.photos.enable = true;
    # TODO: update to send pdf to cloud for paperless-ngx
    downloadFolderOrganizer.enable = false;
  };
  # services
  service = {
    networking = {
      enable = true;
      wireless.enable = false;
    };
    bluetooth.enable = true;
  };
  internationalisation.enable = true;
  services.docker.enable = true;
  transmission.enable = false; # home server

  # programming
  android.enable = true; # for adb
  gaming = {
    enable = true;
    mangohud.enable = true;
  };
  yubico.enable = true;
  yubico.keyID = "24978052"; # TODO: add in nix-sops

  nix = {
    optimise.automatic = true;
    settings = {
      warn-dirty = false;
      experimental-features = "nix-command flakes";
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
    };
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ]; # for nix.nix
  };

  programs.fish.enable = true;
  programs.ssh = {
    startAgent = true;
  };
  users.users.${meta.username} = {
    home = "/home/henri";
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMCpHZBybBTCsCyW6/Q4OZ07SvUpRUvclc10u25j0B+Q hvandersleyen@gmail.com"
    ];
  };

  environment.systemPackages = with pkgs; [
    gnumake
    cachix
    lsof
    spotify
  ];

  home-manager.backupFileExtension = "backup";

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    nerd-font-patcher
    recursive
  ];

  environment.variables = {
    MOZ_ENABLE_WAYLAND = "1"; # For Firefox, similar for other apps
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
    USE_WAYLAND_GRIM = "1";
    # XDG_CONFIG_HOME = "/users/henri.vandersleyen"; # issue with nushell
  };
  programs.hyprland = {
    enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  services = {
    greetd = {
      enable = true;
      settings = {
        initial_session = {
          command = "Hyprland";
          user = "henri";
        };
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
          user = "greeter";
        };
      };
    };
    openssh = {
      enable = true;
    };
    displayManager = {
      autoLogin = {
        enable = true;
        user = "${meta.username}";
      };
      gdm = {
        enable = false;
        wayland = true;
      };
    };
    xserver = {
      enable = true;
      displayManager.sessionCommands = ''
        export XDG_CURRENT_DESKTOP="Hyprland"
        export XDG_SESSION_TYPE="wayland"
      '';
    };
  };
  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=3600
  '';
  # TODO: opening a browser;
  xdg = {
    portal = {
      enable = true;
      # extraPortals = with pkgs; [
      # ];
      config.common.default = [
        "hyprland"
        "gtk"
      ];
    };
    mime = {
      enable = true;
      # xdg-mime query default application/pdf

      defaultApplications = {
        # browser
        "text/html" = "brave.desktop";
        "x-scheme-handler/http" = "brave.desktop";
        "x-scheme-handler/https" = "brave.desktop";
        "x-scheme-handler/about" = "brave.desktop";

        "application/pdf" = [ "zathura.desktop" ];
        "application/json" = [ "nvim.desktop" ]; # You'll need a .desktop file for Vim or your preferred editor
        "text/plain" = [ "nvim.desktop" ];
        # Video formats
        "video/mp4" = [ "vlc.desktop" ];
        "video/mpeg" = [ "vlc.desktop" ];
        "video/x-matroska" = [ "vlc.desktop" ];
        "video/quicktime" = [ "vlc.desktop" ];
        "video/x-msvideo" = [ "vlc.desktop" ]; # AVI
        "video/webm" = [ "vlc.desktop" ];
        # Directories
        "inode/directory" = [ "thunar.desktop" ];
        # Images
        "image/jpeg" = [ "feh.desktop" ];
        "image/png" = [ "feh.desktop" ];
        "image/gif" = [ "feh.desktop" ];
        "image/webp" = [ "feh.desktop" ];
        # audio
        "audio/mpeg" = [ "vlc.desktop" ];
        "audio/flac" = [ "vlc.desktop" ];
      };
    };
  };
}
