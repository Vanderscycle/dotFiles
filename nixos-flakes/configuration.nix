# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # ----------------------
  # Nix Settings
  # ----------------------
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  # ----------------------
  # fonts
  # ----------------------
  #fonts.packages = with pkgs; [
  #  noto-fonts-cjk-sans
  #  noto-fonts-cjk-serif
  #  (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  #  noto-fonts
  #  noto-fonts-extra
  #];

  # ----------------------
  # Bootloader
  # ---------------------  
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 5;
    };
  };

  # ----------------------
  # networking 
  # ---------------------  
  networking = {
    hostName = "nixos-laptop"; # Define your hostname.
    networkmanager.enable = true;
    extraHosts =
      let
        hostsPath = https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts;
        hostsFile = builtins.fetchurl hostsPath;
      in
      builtins.readFile "${hostsFile}";
    firewall.allowedTCPPorts = [ 4566 ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    firewall.enable = true;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # ----------------------
  # time
  # ---------------------  
  time.timeZone = "America/Vancouver";

  # ----------------------
  # Input methods/languages
  # ---------------------
  i18n.defaultLocale = "en_CA.UTF-8";

  # ---------------------
  # Display Configuration
  # ---------------------
  services = {
    printing.enable = true;
    xserver = {
      enable = true;
      # Enable the XFCE Desktop Environment.
      desktopManager.xfce.enable = true;
      displayManager = {
        lightdm.enable = true;
        autoLogin = {
          enable = true;
          user = "henri";
        };
      };
      layout = "us";
      xkbVariant = "";

    };
  };

  # Enable CUPS to print documents.

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.openssh.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # ----------------------
  # user 
  # ---------------------
  users.users.henri = {
    isNormalUser = true;
    description = "Henri Vandersleyen";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      nixpkgs-fmt
      vim
      firefox
    ];
  };

  # ----------------------
  # nixpkgs settings
  # ----------------------
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nixpkgs-fmt
    vim
    docker
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  ];

  # ----------------------
  # Default programs
  # ---------------------
  programs = {
    git.enable = true;
    dconf.enable = true;
    fish.enable = true;
    ssh.startAgent = true;
  };

  # ----------------------
  # Docker + Containers
  # ---------------------
  virtualisation = {
    oci-containers = {
      backend = "docker";
      containers = { };
    };
    docker = {
      enable = true;
      # storageDriver = "btrfs";
      rootless = {
        setSocketVariable = true;
        enable = true;
      };
    };
  };
  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
