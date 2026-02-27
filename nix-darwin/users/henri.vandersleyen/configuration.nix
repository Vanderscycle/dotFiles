{
  pkgs,
  meta,
  inputs,
  ...
}:
# https://daiderd.com/nix-darwin/manual/index.html
{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
    # ./modules/services/appleTouchId.nix
  ];

  nix = {
    enable = true;
    settings = {
      warn-dirty = false;
      experimental-features = "nix-command flakes";
    };
    # Optimize storage and automatic scheduled GC running
    # If you want to run GC manually, use commands:
    # `nix-store --optimize` for finding and eliminating redundant copies of identical store paths
    # `nix-store --gc` for optimizing the nix store and removing unreferenced and obsolete store paths
    # `nix-collect-garbage -d` for deleting old generations of user profiles
    optimise.automatic = true;
    gc = {
      automatic = true;
      # interval = "weekly";
      options = "--delete-older-than 14d";
    };
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ]; # for nix.nix
  };

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
    config.allowBroken = true; # temporary
    config.allowUnsupportedSystem = true;
  };

  # system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 5;
  system.startup = {
    chime = false;
  };
  system.defaults = {
    NSGlobalDomain = {
      InitialKeyRepeat = 15; # slider values: 120, 94, 68, 35, 25, 15
      KeyRepeat = 2; # slider values: 120, 90, 60, 30, 12, 6, 2
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticWindowAnimationsEnabled = true;
      NSDisableAutomaticTermination = null;
      NSDocumentSaveNewDocumentsToCloud = false;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      NSScrollAnimationEnabled = true;
      NSTableViewDefaultSizeMode = 2;
      NSTextShowsControlCharacters = false;
      NSUseAnimatedFocusRing = true;
      NSWindowResizeTime = 2.0e-2;
      PMPrintingExpandedStateForPrint = true;
      PMPrintingExpandedStateForPrint2 = true;
      AppleInterfaceStyle = "Dark";
      "com.apple.swipescrolldirection" = false;
    };
    finder = {
      _FXShowPosixPathInTitle = false;
      _FXSortFoldersFirst = true;
      AppleShowAllExtensions = true;
      AppleShowAllFiles = false;
      CreateDesktop = true;
      FXDefaultSearchScope = "SCcf";
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "clmv";
      QuitMenuItem = false;
      ShowPathbar = true;
      ShowStatusBar = false;
    };
    trackpad = {
      ActuationStrength = 1;
      Clicking = true;
      Dragging = true;
      FirstClickThreshold = 1;
      SecondClickThreshold = 2;
      TrackpadRightClick = true;
      TrackpadThreeFingerDrag = true;
      TrackpadThreeFingerTapGesture = 0;
    };
    # universalaccess = {
    #   closeViewScrollWheelToggle = false;
    #   closeViewZoomFollowsFocus = false;
    #   reduceTransparency = false;
    #   mouseDriverCursorSize = 1.0;
    # };
    SoftwareUpdate = {
      AutomaticallyInstallMacOSUpdates = true;
    };
    dock = {
      appswitcher-all-displays = true;
      autohide = false;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.15;
      dashboard-in-overlay = false;
      enable-spring-load-actions-on-all-items = false;
      expose-animation-duration = 0.2;
      expose-group-apps = false;
      launchanim = true;
      mineffect = "genie";
      minimize-to-application = false;
      mouse-over-hilite-stack = true;
      mru-spaces = false;
      orientation = "bottom";
      show-process-indicators = true;
      show-recents = true;
      showhidden = true;
      static-only = false;
      tilesize = 48;
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
      persistent-apps = [
        "/System/Applications/Launchpad.app"
        "/Applications/Postman.app"
        "/Applications/Visual\ Studio\ Code.app"
        "/Applications/Spotify.app"
        "/Applications/1Password.app"
        "/Applications/Arc.app"
        "/Applications/Kandji Self Service.app"
        "/System/Applications/Calendar.app"
        "/System/Applications/Maps.app"
        "/System/Applications/System Settings.app"

      ];
      # persistent-others = [ "${userHome}/Downloads/" ];
    };
  };

  users.users.${meta.username} = {
    home = "/Users/${meta.username}";
    shell = pkgs.nushell;
  };
  home-manager.backupFileExtension = "backup";
  # fonts.fontDir.enable = true;  # not required for nix-darwin

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  environment = {
    systemPackages = with pkgs; [
      sops
    ];
    variables = {
      # XDG_CONFIG_HOME = "/Users/henri.vandersleyen"; # issue with nushell
      SOPS_AGE_KEY_FILE = "/Users/${meta.username}/.config/sops/age/keys.txt";
      DOCKER_HOST = "unix:///var/run/docker.sock";
    };
  };

  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=3600
  '';

  # Homebrew needs to be installed on its own!
  system.primaryUser = meta.username;
  nix-homebrew = {
    enable = true;
    enableRosetta = true; # Only for Apple Silicon (M1/M2)
    user = meta.username;
    autoMigrate = true;
  };
  homebrew = {
    enable = true;
    casks = [
      "rectangle"
      "iterm2"
      "postman"
      "arc"
      "spotify"
      "docker-desktop"
      "fellow"
      "font-jetbrains-mono"
      "slack"
      "visual-studio-code"
    ];
    brews = [
      "yarn"
      "nvm"
      "dive"
      "aws-sam-cli"
      "awscli"
    ];
  };
}
