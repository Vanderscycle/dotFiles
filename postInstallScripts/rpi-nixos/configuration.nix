
{ config, pkgs, libs, lib, ... }:

# https://nixos.wiki/wiki/NixOS_on_ARM/Raspberry_Pi
let 
  secrets = import ./secrets.nix;
in
{
  imports = [ <nixpkgs/nixos/modules/installer/cd-dvd/sd-image-raspberrypi4.nix> ];

  # audio
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  # boot
  boot = {
    loader = {
      
      # NixOS wants to enable GRUB by default
      grub.enable = false;

      # Enables the generation of /boot/extlinux/extlinux.conf
      generic-extlinux-compatible.enable = true; 

      raspberryPi.firmwareConfig = ''
        dtparam=audio=on
      '';
    };
  };

  # packages + env variables
  environment = {
  variables = {
    EDITOR = "vim";
  };
  systemPackages = with pkgs; [
    curl
    file
    fzf
    gcc
    git
    htop
    libraspberrypi
    lsof
    parted
    pstree
    python3
    ripgrep
    nixpkgs-fmt
    raspberrypi-eeprom
    shadowsocks-libev
    stress-ng
    tree
    vim
    usbutils
    wireguard
    wget
    docker
    fish
    ];
  };

  # put your own configuration here, for example ssh keys:
  users = {
    defaultUserShell = pkgs.fish;
    mutableUsers = true;
    groups = {
      nixos = {
        gid = 1000;
        name = "nixos";
      };
    };
    users = {
      nixos = {
        uid = 1000;
        home = "/home/nixos";
        name = "nixos";
        group = "nixos";
        shell = pkgs.fish;
        extraGroups = [ "wheel" "docker" ];
      };
    };
    
  };
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];


  # Set your time zone.
  time.timeZone = "America/Vancouver";

  virtualisation.docker.enable = true;
  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # Enable the OpenSSH daemon.
  services = {
    openssh = {
      enable = true;
      permitRootLogin = "no";
      passwordAuthentication = false;
    };
    xserver = {
      enable = true;
      displayManager.slim.enable = true;
      desktopManager.gnome3.enable = true;
      videoDrivers = [ "fbdev" ];
    };
  };

  # bluetooth
  systemd.services.btattach = {
    before = [ "bluetooth.service" ];
    after = [ "dev-ttyAMA0.device" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.bluez}/bin/btattach -B /dev/ttyAMA0 -P bcm -S 3000000";
    };
  };

networking = {

  wireless.enable = false;
  interfaces.eth0.ipv4.addresses = [ {
    address = "192.168.1.2";
    prefixLength = 24;
  } ];

  defaultGateway = "192.168.1.1";
  nameservers = [ "8.8.8.8" ];

  hostName = "rpi-plex";
  firewall = {

    # Open ports in the firewall.
    allowedTCPPorts = [ 20 80 443 ];
  # allowedUDPPorts = [ ... ];
    };
  };

  # nix specifc
  nix = {
    autoOptimiseStore = true;
    gc = { # garbage collector
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    # Free up to 1GiB whenever there is less than 100MiB left.
    extraOptions = ''
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
  };

  nixpkgs.config = {
    allowUnfree = true;
  };
}
