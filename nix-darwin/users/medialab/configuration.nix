{
  inputs,
  meta,
  config,
  hosts,
  pkgs,
  ...
}:
{
  imports = [
    hosts.nixosModule
    ../../hosts/medialab
    # programs
    ../../nix-modules/programs
    # services
    ../../nix-modules/services
    # local
    ./sops.nix
  ];

  programs.fish.enable = true;
  # services
  bluetooth.enable = true;
  internationalisation.enable = true;
  docker.enable = true;
  system.stateVersion = "25.05";
  nix = {
    optimise.automatic = true;
    settings = {
      warn-dirty = false;
      experimental-features = "nix-command flakes";
      substituters = [ ];
      trusted-public-keys = [ ];
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
    };

    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ]; # for nix.nix
  };

  nixpkgs = {
    hostPlatform = meta.system;
    config.allowUnfree = true;
  };

  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=3600
  '';

  services = {
    openssh = {
      enable = true;
    };
    displayManager = {
      autoLogin = {
        enable = true;
        user = "${meta.username}";
      };
    };
    xserver = {
      enable = true;
      displayManager.lightdm.enable = true;
      desktopManager.xfce.enable = true;
    };
  };

  networking.wireless.enable = true;
  users.users.${meta.username} = {
    home = "/home/${meta.username}";
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  environment.systemPackages = with pkgs; [
    jellyfin
  ];

  home-manager.backupFileExtension = "backup";

  # fonts.enableFontDir = true;
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-font-patcher
    recursive
  ];
}
