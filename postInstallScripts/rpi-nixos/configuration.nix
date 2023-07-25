
{ config, pkgs, libs, lib, ... }:

# https://nixos.wiki/wiki/NixOS_on_ARM/Raspberry_Pi
let 
  secrets = import ./secrets.nix;
in
{
  imports = [ <nixpkgs/nixos/modules/installer/cd-dvd/sd-image-raspberrypi4.nix> ];

  networking.wireless.enable = false;
  services.xserver = {
    enable = true;
    displayManager.slim.enable = true;
    desktopManager.gnome3.enable = true;
    videoDrivers = [ "fbdev" ];
  };
  # audio
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  boot.loader.raspberryPi.firmwareConfig = ''
    dtparam=audio=on
  '';

  # packages + env variables
  environment = {
  variables = {
    EDITOR = "vim";
  };
  systemPackages = with pkgs; [
    bind
    curl
    elinks
    file
    fzf
    gcc
    git
    hdparm
    htop
    inadyn
    libraspberrypi
    lsof
    nginx
    nmon
    parted
    php
    pstree
    python3
    ripgrep
    ncdu
    nixpkgs-fmt
    raspberrypi-eeprom
    shadowsocks-libev
    stress-ng
    tree
    vim
    usbutils
    wireguard
    wget
  ];
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  # bluetooth
  systemd.services.btattach = {
    before = [ "bluetooth.service" ];
    after = [ "dev-ttyAMA0.device" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.bluez}/bin/btattach -B /dev/ttyAMA0 -P bcm -S 3000000";
    };
  };


  # Set your time zone.
  time.timeZone = "America/Vancouver";

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
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

networking = {

  interfaces.eth0.ipv4.addresses = [ {
  address = "192.168.1.2";
  prefixLength = 24;
  } ];

  defaultGateway = "192.168.1.1";
  nameservers = [ "8.8.8.8" ];

  hostName = "rpi-plex";
  firewall = {
    allowedTCPPorts = [ 20 80 443 ];
  # allowedUDPPorts = [ ... ];
    };
  };
    # Open ports in the firewall.
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
