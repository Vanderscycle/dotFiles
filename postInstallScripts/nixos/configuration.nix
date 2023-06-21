# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

	# flake 
	# https://nixos.wiki/wiki/Flakes
	 nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  # Enable the XFCE Desktop Environment.
# desktopManager = {
# xfce = {
# enable = true;
# };
# };
# displayManager = {
# lightdm = {
# enable = true;
# };
# autoLogin = {
# enable = true;
# user = "henri";
# };
# };

    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks # is the package manager for Lua modules
        luadbi-mysql # Database abstraction layer
      ];

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
# awesome wm
# https://nixos.wiki/wiki/Awesome
  };


  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services = { 

  # Enable CUPS to print documents.
printing.enable = true;
  # Enalbe oenssh-server
openssh = {
    enable = true;
    openFirewall = true;
    settings = {
    PermitRootLogin = "no";         # disable root login
    PasswordAuthentication = false; # disable password login
    X11Forwarding = true;              # enable X11 forwarding
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
  users.users.henri = {
    isNormalUser = true;
    description = "Henri Vandersleyen";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    shell = pkgs.fish;
    packages = with pkgs; [
	# editor
      	emacs
	vim
	# languages
	luajitPackages.luarocks
	# nixos
	home-manager
	# shell
	starship
	fish
	fishPlugins.done
	fishPlugins.fzf
	fishPlugins.autopair
	fishPlugins.z
	kitty
	wezterm
	git
	# client
	awscli2
	linode-cli
	# cli
	tldr
	rsync
	fd
	exa
	bat
	lazygit
	unzip
	fzf
	yq	
	jq
	ripgrep
	silver-searcher
	btop
	httpie
	xclip
	broot
	zoxide
	nnn
	xclip
	#3d printing/cad
	super-slicer-latest
	#devops
	helm
	kubernetes
	docker
	ansible
	kustomize
	tilt
	terraform
	# gui
	vlc
	transmission
	xfce.thunar
	nitrogen
	#insomniac
	slack
	firefox
	# social
	zoom
	discord
	betterdiscordctl
	spotify
	spicetify-cli
	# gaming	
	steam
    #  thunderbird
    ];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
shells = with pkgs; [ fish ];
variables = {
EDITOR = "emacs";
VISUAL = "emacs";
};
systemPackages = with pkgs; [
ansible
git
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
emacs
fd
ripgrep
    # install helix from flake input `helix`
    helix."${pkgs.system}".packages.helix

  ];
};
# steam config
# https://nixos.wiki/wiki/Steam
	programs = {
fish = {
enable = true;
};
steam = {
	 enable = true;
	 remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
	 dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
	};
};
# docker
# https://nixos.wiki/wiki/Docker
virtualisation.docker = {
	enable = true;
	storageDriver = "btrfs";
	rootless.setSocketVariable = true;
};

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