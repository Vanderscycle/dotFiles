# ============================================================================================
#
# ███╗   ██╗██╗██╗  ██╗ ██████╗ ███████╗     ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ 
# ████╗  ██║██║╚██╗██╔╝██╔═══██╗██╔════╝    ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ 
# ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║███████╗    ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
# ██║╚██╗██║██║ ██╔██╗ ██║   ██║╚════██║    ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
# ██║ ╚████║██║██╔╝ ██╗╚██████╔╝███████║    ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
# ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝     ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ 
#
# ============================================================================================

# ----------------------
# Imports and variables
# ---------------------

{ unstable, inputs, config, lib, pkgs, ... }:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];


  # ----------------------
  # Nix Settings
  # ---------------------  
  nix = {
    # https://nixos.wiki/wiki/Flakes
    package = pkgs.nixFlakes;
    # Free up to 1GiB whenever there is less than 100MiB left.
    extraOptions = ''
      experimental-features = nix-command flakes
      warn-dirty = false
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # ----------------------
  # nixpkgs settings
  # ---------------------  
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "steam"
        "steam-original"
        "steam-run"
      ];
      permittedInsecurePackages = [
        "electron-12.2.3"
      ];
    };
  };

  # ----------------------
  # fonts
  # ---------------------  
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    noto-fonts
    noto-fonts-extra
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];

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
    hostName = "nixos-desktop"; # Define your hostname.
    networkmanager.enable = true;
    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # firewall.enable = false;
  };

  # ----------------------
  # time
  # ---------------------  
  time.timeZone = "America/Vancouver";

  # ---------------------
  # sound
  # ---------------------
  sound.enable = true;
  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = true;
  };

  # ---------------------
  # Security
  # ---------------------
  security = {
    rtkit.enable = true;
    # https://github.com/NixOS/nixpkgs/issues/40157#issuecomment-387269306
    sudo.extraConfig = ''
      Defaults        timestamp_timeout=300
    '';
  };

  # ---------------------
  # Display Configuration
  # ---------------------
  # awesome wm (x)
  # services = {
  #   # Configure keymap in X11
  #   xserver = {
  #     # Enable the X11 windowing system.
  #     enable = true;
  #     layout = "us";
  #     xkbVariant = "";

  #     windowManager.awesome = {
  #       enable = true;
  #     };
  #     displayManager = {
  #       sddm.enable = true;
  #       defaultSession = "none+awesome";
  #       # Enable automatic login for the user.
  #       autoLogin = {
  #         enable = true;
  #         user = "henri";
  #       };
  #     };
  #   };
  # };
  # hyprland (wayland)
  services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      excludePackages = [ pkgs.xterm ];
      libinput.enable = true;
      displayManager = {
        autoLogin = {
          enable = true;
          user = "henri";
        };
        gdm = {
          enable = true;
          wayland = true;
        };
      };
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      gtkUsePortal = true;
    };
  };

  # ----------------------
  # user + home-manager
  # ---------------------
  home-manager.users.henri.imports = [ /home/henri/.config/home-manager/home.nix ];
  home-manager.extraSpecialArgs = { inherit unstable; };
  users.users.henri = {
    isNormalUser = true;
    description = "Henri Vandersleyen";
    extraGroups = [ "networkmanager" "wheel" "docker" "storage" ];
    shell = pkgs.fish;
  };

  # ----------------------
  # Default packages + env variables
  # ---------------------
  environment = {

    sessionVariables = rec {
      SUDO_EDITOR = "emacs";
    };
    systemPackages = with pkgs; [
      # wayland
      waybar

  (import (fetchTarball "https://install.devenv.sh/latest")).default
      docker
      git
      fish
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      helix
      fd
      ripgrep
      xorg.xkill
    ];
  };

  # ----------------------
  # Default programs
  # ---------------------
  programs = {
    # https://github.com/nix-community/home-manager/issues/3113#issuecomment-1194271028
    dconf.enable = true;
    fish.enable = true;
    ssh.startAgent = true;
    # https://nixos.wiki/wiki/Steam
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
  };

  # ----------------------
  # Docker + Containers
  # ---------------------
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

  # ----------------------
  # File system and drives
  # ---------------------
  fileSystems."/mnt/backup" = {
    device = "/dev/nvme1n1p1";
    fsType = "auto";
    options = [ "defaults" "noatime" "nofail" "compress=zstd" ];
  };

  # ---------------------
  # Services
  # ---------------------
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

  # ----------------------
  # Input methods/languages
  # ---------------------
  console.useXkbConfig = true;
  i18n = {
    # Select internationalisation properties.
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


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
