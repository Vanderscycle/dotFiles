# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  inputs,
  pkgs,
  meta,
  ...
}:

# STATUS:
# Nextcloud works but I do want it to use /mnt/nextcloud
{
  imports = [
    ./hardware-configuration.nix
    ./fstab.nix
    ./traefik.nix
    ./sops.nix
    ./services
    ./containers
    ./servers
  ];

  nix = {
    optimise.automatic = true;
    settings = {
      experimental-features = "nix-command flakes";
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
    };
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ]; # for nix.nix
  };

  nixpkgs = {
    hostPlatform = "x86_64-linux";
    config.allowUnfree = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    grub.enable = true;
    grub.device = "/dev/sda"; # Install GRUB to the MBR
    efi.canTouchEfiVariables = false; # Disable EFI settings since you're using legacy boot.
  };

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    #useXkbConfig = true; # use xkb.options in tty.
  };
  users.groups.smbaccess = { };

  users.users.radarr = {
    isNormalUser = false;
    extraGroups = [ "smbaccess" ];
  };
  users.users.${meta.username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "smbaccess"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
    # Created using mkpasswd
    hashedPassword = "$6$NQrAUhx13piyrmgZ$GFNEe2v/1tbRO5M3806EWcsoHifN1GIIzhLz.hsVv8Ug3nKgLzP/PMm6MzAS.XRJwzfpdK28LdMLG9uIRtibn/";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMCpHZBybBTCsCyW6/Q4OZ07SvUpRUvclc10u25j0B+Q hvandersleyen@gmail.com"
    ];
  };
  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=3600
  '';
  environment.systemPackages = with pkgs; [
    sops
    git
    vim
    tree
    sysz
    samba
    openssl
  ];

  systemd.tmpfiles.rules = [
    # d (directory)
    "d /home/monolith/Saves 0755 monolith users -"
    "d /mnt/rice/famjam/nextcloud 0750 nextcloud nextcloud -"
  ];
  # id monolith ( get details on the user )
  services.openssh.enable = true;

  # docker
  virtualisation.oci-containers = {
    backend = "docker";
  };

  systemd.services.traefik.serviceConfig = {
    ReadWritePaths = [ "/var/lib/traefik" ];
  };

  environment.etc."nextcloud-admin-pass".text =
    builtins.readFile
      config.sops.secrets."nextcloud/admin/password".path;
  services.nginx.virtualHosts."${meta.hostname}".listen = [
    {
      addr = "0.0.0.0";
      port = 9999;
    }
  ];

  services.nextcloud = {
    enable = true;
    hostName = meta.hostname;
    # datadir = "/mnt/nextcloud/nextcloud";
    config = {
      adminpassFile = "/etc/nextcloud-admin-pass";
      # dbtype = "pgsql";
      dbtype = "sqlite";
    };
    settings = {
      trusted_domains = [
        "192.168.4.129"
        "nextcloud.homecloud.lan"
      ];
      # overwrite.cli.url = "http://192.168.4.129/nextcloud";
      # overwritewebroot = "/nextcloud";
    };
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps)
        news
        contacts
        calendar
        tasks
        ;
    };
    extraAppsEnable = true;
  };

  services.kavita = {
    enable = true;
    tokenKeyFile = config.sops.secrets."kavita/token".path;
  };

  services.uptime-kuma = {
    enable = true;
    appriseSupport = true;
    settings = {
      PORT = "4100";
    };
  };

  # dashboard
  services.grafana = {
    enable = true;
    settings.server = {
      http_port = 4010;
    };
  };

  # containers
  container.homarr.enable = true;

  # services
  service = {
    transmission.enable = true;
    n8n.enable = true;
    filebrowser.enable = true;
    jellyfin.enable = true;
    servarr = {
      radarr.enable = true;
      sonarr.enable = true;
      bazarr.enable = true;
      lidarr.enable = true;
      prowlarr.enable = true;
      readarr.enable = true;
    };
  };

  # programming
  service.gitea.enable = true;

  # metric gathering
  services.prometheus = {
    enable = true;
    port = 4011;
    exporters = {
      node = {
        enable = true;
      };
      exportarr-readarr = {
        enable = true;
        user = "admin";
        apiKeyFile = config.sops.secrets."servarr/readarr/api_key".path;
      };
    };
    scrapeConfigs = [
      # TODO: another note
      # check for options
      # nixos-option services.filebrowser.enable
      #TODO: make a note
      # {
      #   job_name = "readarr-exporter";
      #   static_configs = [{
      #     # Target the exporter on localhost (if on same machine)
      #     targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.exportarr-readarr.port}" ];
      #   }];
      # }
      {
        job_name = "readarr";
        static_configs = [
          {
            targets = [ "readarr.homecloud.lan" ];
          }
        ];
      }
    ];
  };

  services.home-assistant = {
    enable = true;
    openFirewall = false;
    config = {
      use_x_forwarded_for = true;
      trusted_proxies = [
        "127.0.0.1"
        "0.0.0.0"
      ];
      http.server_host = "0.0.0.0";
      http.server_port = 8123;
    };
  };
  # networking
  networking = {
    hosts = {
      "192.168.4.129" = [
      ];
    };
    defaultGateway = "192.168.4.1"; # Point to Proxmox
    nameservers = [ "192.168.1.1" ]; # Ensure DNS resolution
    hostName = meta.hostname; # Define your hostname.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
    firewall = {
      enable = false;
      allowedUDPPorts = [ 34197 ]; # Explicitly open Factorio port
      allowedTCPPorts = [
        80
        8080 # traefik dashboard
        27015 # factorio
      ];
    };
  };
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}
