# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  inputs,
  pkgs,
  lib,
  meta,
  ...
}:

# STATUS:
# Nextcloud works but I do want it to use /mnt/nextcloud
# paperless works but I do want it ot user /mnt/paperless
{
  imports = [
    ./hardware-configuration.nix
    ./fstab.nix
    ./traefik.nix
    ./sops.nix
    ./services
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
  users.users.nextcloud = {
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
    # Copy/Link the save file (use either C or L)
    "C /var/lib/factorio/saves/save1.zip - - - - ${builtins.path { path = ./save1.zip; }}"
    # d (directory)
    "d /home/monolith/Saves 0755 monolith users -"
    "d /mnt/rice/famjam/nextcloud 0750 nextcloud nextcloud -"
  ];
  # id monolith ( get details on the user )
  services.openssh.enable = true;
  systemd.timers."factorioSaves" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      Unit = "factorioSaves.service";
    };
  };
  systemd.services."factorioSaves" = {
    script = ''
      cd "/var/lib/factorio/saves/"
      DATE=$(date +%F)
      ${pkgs.rsync}/bin/rsync -avz save1.zip "/home/${meta.username}/Saves/save1-$DATE.zip"
    '';
    path = [
      pkgs.rsync
      pkgs.coreutils # for `date`
    ];
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
  services.factorio = {
    bind = "192.168.4.129";
    package = pkgs.factorio-headless.override (oldAttrs: {
      versionsJson = ./versions.json;
      username = builtins.readFile config.sops.secrets."factorio/admin".path;
      token = builtins.readFile config.sops.secrets."factorio/token".path;
    });
    enable = true;
    public = true;
    username = builtins.readFile config.sops.secrets."factorio/admin".path;
    token = builtins.readFile config.sops.secrets."factorio/token".path;
    openFirewall = true;
    stateDirName = "factorio";
    extraSettingsFile = pkgs.writeText "server-settings.json" (
      builtins.toJSON {
        game_password = builtins.readFile config.sops.secrets."factorio/game-password".path;
      }
    );
    extraSettings = {
      max_players = 16;
    };
    autosave-interval = 20;
    saveName = "save1";
    game-name = "[NixOs] factorio";
    description = "Factorio on nixos";
    admins = [
      (builtins.readFile config.sops.secrets."factorio/admin".path)
    ];
  };
  # docker
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      # https://search.nixos.org/options?channel=24.11&from=0&size=50&sort=relevance&type=packages&query=oci-containers.containers
      hello-world = {
        image = "hello-world:latest";
        autoStart = false;
      };
      homarr = {
        image = "ghcr.io/homarr-labs/homarr:latest";
        ports = [ "7575:7575" ];
        # extraOptions = [ "--network=host" ]; # TODO: check for traefik
        environment = {
          SECRET_ENCRYPTION_KEY = builtins.readFile config.sops.secrets."docker/homarr/enc_key".path;
        };
        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock"
          "/home/${meta.username}/docker/homarr:/appdata"
        ];
      };
    };
  };
  # reverse proxy

  systemd.services.traefik.serviceConfig = {
    ReadWritePaths = [ "/var/lib/traefik" ];
  };
  services.n8n = {
    enable = true;
    openFirewall = true;
    settings = {
    };
  };
  #INFO: a way to set env vars for services
  systemd.services.n8n.environment = {
    N8N_SECURE_COOKIE = "false";
    N8N_LISTEN_ADDRESS = "0.0.0.0";
    N8N_METRICS = "true"; # prometheus
    # N8N_PATH = "/n8n"; # base url
  };
  services.gitea = {
    enable = true;
    settings = {
      # server.ROOT_URL = "http://0.0.0.0/gitea/";
      server.HTTP_PORT = 3001;
      metrics = {
        ENABLED = true;
      };
    };
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

  services.uptime-kuma = {
    enable = true;
    appriseSupport = true;
    settings = {
      PORT = "4100";
    };
  };
  # media org tool (movies)
  # 7878
  services.radarr = {
    enable = true;
    openFirewall = false;
    # dataDir = "";
  };

  # media org tool (tv shows)
  # port 8989
  services.sonarr = {
    enable = true;
    openFirewall = false;
    # dataDir = "";
  };

  # subtitles
  services.bazarr = {
    enable = true;
    openFirewall = false;
    listenPort = 6767;
  };

  # media org tool (music)
  # 8686
  services.lidarr = {
    enable = true;
    openFirewall = false;
    # dataDir = "";
  };

  # usenet management tool
  # 9696
  services.prowlarr = {
    enable = true;
    openFirewall = false;
  };

  # goodles photos like
  services.immich = {
    enable = true;
    openFirewall = false;
    port = 2283;
    settings = { };
    # mediaLocation = "";
  };

  # dashboard
  services.grafana = {
    enable = true;
    settings.server = {
      http_port = 4010;
    };
  };

  # metric gathering
  services.prometheus = {
    enable = true;
    port = 4011;
    exporters.node = {
      enable = true;
    };
    scrapeConfigs = [
      {
        job_name = "n8n";
        static_configs = [
          {
            targets = [ "n8n.homecloud.lan" ];
          }
        ];
      }
      {
        job_name = "gitea";
        static_configs = [
          {
            targets = [ "gitea.homecloud.lan" ];
          }
        ];
      }
    ];
  };

  services.transmission = {
    enable = true;
    openFirewall = false; # INFO: we use traefik
    openPeerPorts = true;
    settings = {
      rpc-port = 9091;
      rpc-bind-addres = "0.0.0.0";
      download-dir = "/mnt/transmission";
    };
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
