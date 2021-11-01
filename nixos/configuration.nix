  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };


  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  #nixpkgs.config.pulseaudio = true;
  #hardware.pulseaudio.enable = true;
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware  = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.henri = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "docker"]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also insta>
  #   wget
  #   firefox
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };
   programs.zsh.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
      programs.xwayland.enable = true;
    services = {
        gnome.core-os-services.enable = true;
        xserver = {
            enable = true;
            libinput.enable = true;

            displayManager = {
                gdm.enable = true;
                gdm.autoSuspend = false;
            };
            desktopManager = {
                gnome = {
                    extraGSettingsOverrides = ''
                        [org.gnome.nautilus.preferences]
                        default-folder-viewer='list-view'
                        search-filter-time-type='last-modified'
                        search-view='list-view'
                        show-delete-permanently=true
                        [org.gnome.desktop.wm.preferences]
                        button-layout='appmenu:minimize,maximize,close'
                        [org.gnome.desktop.input-sources]
                        [('xkb', 'us+colemak')]
                    '';
                    enable = true;
                };
            };
        };
    };
    environment.systemPackages = with pkgs; [
#wm

        gnome.gnome-shell-extensions
        gnome.dconf-editor
        
        
#dootfiles management
home-manager
#system
brave
firefox
nerdfonts
#dev
postman
vim
neovim
git
docker
docker-compose
nodejs
conda
#terminal
curl
wget
alacritty
zsh
oh-my-zsh
rsync
exa
bat
fzf
htop
tmux
tmuxinator
lsof
#db
mongodb
postgresql
mongodb-compass
#entertainment
vlc
steam-tui
spotify-tui

    ];
fonts.fonts = with pkgs; [
  (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "DroidSansMono" ]; })
];
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}
