# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, lib, pkgs, ... }:
let
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # flake 
  # https://nixos.wiki/wiki/Flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      warn-dirty = false
      '';
  };
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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
  
  # Configure keymap in X11
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    layout = "us";
    xkbVariant = "";

    windowManager.awesome = {
      enable = true;
    };
    displayManager = {
      sddm.enable = true;
      defaultSession = "none+awesome";
      # Enable automatic login for the user.
      autoLogin = {
        enable = true;
        user = "henri";
      };
    };
  };

  sound.enable = true;
  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = true;
  };
  security = {
    rtkit.enable = true;
    # https://github.com/NixOS/nixpkgs/issues/40157#issuecomment-387269306
    sudo.extraConfig = ''
      Defaults        timestamp_timeout=300
    '';
  };
  services = {

    # Enable CUPS to print documents.
    printing.enable = true;
    # Enalbe oenssh-server
    openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PermitRootLogin = "no"; # disable root login
        PasswordAuthentication = false; # disable password login
        X11Forwarding = true; # enable X11 forwarding
      };
    };
    # Enable sound with pipewire.
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
  };
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.

  home-manager.users.henri.imports = [ /home/henri/.config/home-manager/home.nix ];
  users.users.henri = {
    isNormalUser = true;
    description = "Henri Vandersleyen";
    extraGroups = [ "networkmanager" "wheel" "docker" "storage" ];
    shell = pkgs.fish;

  };

  # Allow unfree packages
  nixpkgs = {
  config = {
  allowUnfree = true;
  allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-run"
  ];
  };
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    sessionVariables = rec {
      EDITOR = "helix";
    };
    systemPackages = with pkgs; [
      docker
      git
      fish
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      helix
      fd
      ripgrep
    ];
  };
  # steam config
  # https://nixos.wiki/wiki/Steam
  programs = {
    # https://github.com/nix-community/home-manager/issues/3113#issuecomment-1194271028
    dconf.enable = true;
    fish.enable = true;
    ssh.startAgent = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
  };
  # docker
  # https://nixos.wiki/wiki/Docker
  virtualisation = {
    oci-containers = {
      backend = "docker";
      containers = {
        "jsoncrack" = {
          image = "shokohsc/jsoncrack";
          ports = [ "8888:8080" ];
        };
      };
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
  fileSystems."/mnt/backup" = {
    device = "/dev/nvme1n1p1";
    fsType = "auto";
    options = [ "defaults" "noatime" "nofail" "compress=zstd" ];
  };
  console.useXkbConfig = true;
  i18n = {
    inputMethod = {
      enabled = "fcitx5";
      uim.toolbar = "gtk"; # gtk-systray
      fcitx5.addons = with pkgs; [
        # default:
        # fcitx-keyboard-us
        # pinyin

        # add:
        fcitx5-rime # pinyin
        fcitx5-chinese-addons
        fcitx5-with-addons
        # cloudpinyin
        # hangul  # korean
      ];
    };
  };

  #  fileSystems."/mnt/usb" = {
  #    device = "/dev/sda";
  #    fsType = "auto";
  #    options = [ "defaults" "noatime" ];
  #  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
  system.stateVersion = "23.05"; # Did you read the comment?
}
