{
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
    # display-mangers
    ../../nix-modules/window-managers
    # local
    ./sops.nix
    ./nix.nix
  ];

  programs.fish.enable = true;

  # status bars + display managers
  display-manager = {
    xfce.enable = true;
    lightdm.enable = true;
    autologin.enable = true;
  };

  # services
  program = {
    bluetooth.enable = true;
    internationalisation.enable = true;
    networking = {
      enable = true;
      networkmanager.enable = true;
      wireless = {
        enable = false;
        networks = {
          "homelab_wifi" = {
            psk = config.sops.secrets."home-server/wifi/password".path;
          };
        };
      };
    };
  };
  system.stateVersion = "25.05";

  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=3600
  '';

  services = {
    openssh = {
      enable = true;
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
  ];

  home-manager.backupFileExtension = "backup";

  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-font-patcher
    recursive
  ];
}
