{
  pkgs,
  username,
  inputs,
  ...
}:
# https://daiderd.com/nix-darwin/manual/index.html
{
  imports = [
    # ./modules/services/appleTouchId.nix
  ];

  nix = {
    settings.experimental-features = "nix-command flakes";
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
    configureBuildUsers = true;
    useDaemon = true;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ]; # for nix.nix
  };

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
    config.allowUnsupportedSystem = true;
  };

  services.nix-daemon.enable = true;
  # system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 5;

  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.nushell;
  };
  home-manager.backupFileExtension = "backup";
  fonts.packages = with pkgs; [
    jetbrains-mono
  ];

  environment = {
    systemPackages = [
      pkgs.sops
    ];
    variables = {
      # XDG_CONFIG_HOME = "/Users/henri.vandersleyen"; # issue with nushell
      SOPS_AGE_KEY_FILE = "/Users/${username}/.config/sops/age/keys.txt";
    };
  };

  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=3600
  '';

  # Homebrew needs to be installed on its own!
  homebrew = {
    enable = true;
    casks = [
      "rectangle"
      "iterm2"
      # "nikitabobko/tap/aerospace" # not vetted on work laptop
    ];
    brews = [
      # "koekeishiya/formulae/yabai"
      # "koekeishiya/formulae/skhd"
    ];
  };
}
