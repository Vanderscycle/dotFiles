{
  pkgs,
  inputs,
  username,
  hosts,
  ...
}:
{
  imports = [
    hosts.nixosModule
    ../../hosts
    # hardware related
    ../../nix-modules/hardware
    # programs
    ../../nix-modules/programs
    # services
    ../../nix-modules/services
    # systemd/cron
    ../../nix-modules/cron
    # local
    ./sops.nix
  ];
  boot.extraModprobeConfig = ''options bluetooth disable_ertm=1 '';
  # cron
  cron.downloadFolderOrganizer.enable = true;
  # services
  bluetooth.enable = true;
  internationalisation.enable = true;
  docker.enable = true;
  transmission.enable = true;
  # programming
  gaming = {
    enable = true;
    mangohud.enable = true;
  };
  yubico.enable = true;
  yubico.keyID = "24978052"; # TODO: add in nix-sops

  nix = {
    optimise.automatic = true;
    settings = {
      experimental-features = "nix-command flakes";
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };

    gc = {
      automatic = true;
      # interval = "weekly";
      options = "--delete-older-than 14d";
    };

    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ]; # for nix.nix
  };

  nixpkgs = {
    hostPlatform = "x86_64-linux";
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "electron-32.3.3"
      "beekeeper-studio-5.1.5"
    ];
  };

  programs.fish.enable = true;

  users.users.${username} = {
    home = "/home/henri";
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
  };

  environment.systemPackages = with pkgs; [
    gnumake
    cachix
    lsof
    spotify
  ];

  home-manager.backupFileExtension = "backup";

  # fonts.enableFontDir = true;
  fonts.packages = with pkgs; [
    jetbrains-mono
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
    openssh = {
      enable = false;
    };
    displayManager = {
      autoLogin = {
        enable = true;
        user = "${username}";
      };
    };
    xserver = {
      enable = true;
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
      };
    };
  };
  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=3600
  '';

  xdg.mime = {
    defaultApplications = {
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
      # "image/jpeg" = [ "feh.desktop" ];
      # "image/png" = [ "feh.desktop" ];
      # "image/gif" = [ "feh.desktop" ];
      # audio
      "audio/mpeg" = [ "vlc.desktop" ];
      "audio/flac" = [ "vlc.desktop" ];
    };
  };
}
