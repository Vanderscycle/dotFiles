{ inputs, config, lib, pkgs, ... }:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  nix = {
    package = pkgs.nixFlakes;
    # Free up to 1GiB whenever there is less than 100MiB left.
    extraOptions = ''
      experimental-features = nix-command flakes
      warn-dirty = false
      min-free = ${toString (1000 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';

    settings.auto-optimise-store = true;
    # garbarge collector
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
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
      permittedInsecurePackages = [
        "electron-12.2.3"
      ];    
    };
  };
  
boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 5;
    };
  };
  networking = {
    hostName = "nixos-workstation"; # Define your hostname.
    # Enable networking
    networkmanager.enable = true;
  };

  # - user
  home-manager.users.henri.imports = [ /home/henri/.config/home-manager/home.nix ];
  users.users.henri = {
    isNormalUser = true;
    description = "Henri Vandersleyen";
    extraGroups = [ "networkmanager" "wheel" "docker" "storage" ];
    shell = pkgs.fish;
};
  
  # - docker
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

  # - input
  
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

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

 environment = {
    systemPackages = with pkgs; [
      #baremin
      docker
      git
      fish
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      helix
      fd
      ripgrep
      xorg.xkill
      # xfce
      blueman
      firefox
      deja-dup
      drawing
      elementary-xfce-icon-theme
      evince
      firefox
      foliate
      font-manager
      gimp-with-plugins
      gnome.file-roller
      gnome.gnome-disk-utility
      inkscape-with-extensions
      libqalculate
      libreoffice
      orca
      pavucontrol
      qalculate-gtk
      thunderbird
      wmctrl
      xclip
      xcolor
      xcolor
      xdo
      xdotool
      xfce.catfish
      xfce.gigolo
      xfce.orage
      xfce.xfburn
      xfce.xfce4-appfinder
      xfce.xfce4-clipman-plugin
      xfce.xfce4-cpugraph-plugin
      xfce.xfce4-dict
      xfce.xfce4-fsguard-plugin
      xfce.xfce4-genmon-plugin
      xfce.xfce4-netload-plugin
      xfce.xfce4-panel
      xfce.xfce4-pulseaudio-plugin
      xfce.xfce4-systemload-plugin
      xfce.xfce4-weather-plugin
      xfce.xfce4-whiskermenu-plugin
      xfce.xfce4-xkb-plugin
      xfce.xfdashboard
      xorg.xev
      xsel
      xtitle
      xwinmosaic
      zuki-themes
    ];
  };

  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = true;
  };


  programs = {
    fish.enable = true;
    ssh.startAgent = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };

    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };
  };

  security.pam.services.gdm.enableGnomeKeyring = true;

  time.timeZone = "America/Vancouver";
  services = {
    printing.enable = true;
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
    xserver = {
      enable = true;
      excludePackages = with pkgs; [
        xterm
      ];
      displayManager = {
        defaultSession = "xfce";
        lightdm = {
          enable = true;
          greeters.slick = {
            enable = true;
            theme.name = "Zukitre-dark";
          };
        };
      };
      desktopManager.xfce.enable = true;
      windowManager.default = "none+xfce";
    };
  };

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
