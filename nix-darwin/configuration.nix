{ pkgs, inputs, ... }:
{
  imports = [
    # ./modules/services/appleTouchId.nix
  ];
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";
  # Optimize storage and automatic scheduled GC running
  # If you want to run GC manually, use commands:
  # `nix-store --optimize` for finding and eliminating redundant copies of identical store paths
  # `nix-store --gc` for optimizing the nix store and removing unreferenced and obsolete store paths
  # `nix-collect-garbage -d` for deleting old generations of user profiles
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    # interval = "weekly";
    options = "--delete-older-than 14d";
  };
  # system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 5;
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  users.users."henri.vandersleyen".home = "/Users/henri.vandersleyen";
  users.users."henri.vandersleyen".shell = pkgs.nushell;
  home-manager.backupFileExtension = "backup";
  nix.configureBuildUsers = true;
  nix.useDaemon = true;
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ]; # for nix.nix
  # fonts.enableFontDir = true;
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-font-patcher
    recursive
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  environment.variables = {
    # XDG_CONFIG_HOME = "/users/henri.vandersleyen"; # issue with nushell
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
      "nikitabobko/tap/aerospace"
    ];
    brews = [ ];
  };
}
