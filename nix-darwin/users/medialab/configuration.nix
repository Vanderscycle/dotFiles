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
    ../../nix-modules/services/internationalisation.nix
    ../../nix-modules/services/sound.nix
    ../../nix-modules/services/bluetooth.nix
    # local
    ./sops.nix
    ./nix.nix
  ];

  programs.fish.enable = true;
  # services
  bluetooth.enable = true;
  internationalisation.enable = true;
  system.stateVersion = "25.05";

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

  networking.wireless = {
    enable = true;
    networks = {
      "Linksys00356_24GHz" = {
        psk = config.sops.secrets."home-server/wifi/password".path;
      };
    };
  };
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
