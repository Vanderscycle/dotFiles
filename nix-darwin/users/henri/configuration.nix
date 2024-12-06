{ pkgs, inputs, ... }:
{
  imports =
    [
    ../../hosts
    # programs
    ../../nix-modules/programs/gaming.nix
    ../../nix-modules/programs/thunar.nix
    # services
    ../../nix-modules/services/sound.nix
    ../../nix-modules/services/docker.nix
    ../../nix-modules/services/internationalisation.nix
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
  nixpkgs.hostPlatform = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;
  users.users."henri".home = "/home/henri";
  users.users."henri".shell = pkgs.fish;
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

  xdg.mime = {
    defaultApplications = {
      "application/pdf" = [ "zathura.desktop" ];
      "application/json" = [ "nvim.desktop" ]; # You'll need a .desktop file for Vim or your preferred editor
      "text/plain" = [ "nvim.desktop" ];
      # Video formats
      "video/mp4" = [ "vlc.desktop" ];
      "video/mpeg" = [ "vlc.desktop" ];
      "video/x-matroska" = [ "vlc.desktop" ];
      "video/quicktime" = [ "vlc.desktop" ];
      "video/x-msvideo" = [ "vlc.desktop" ]; # AVI
      "video/webm" = [ "vlc.desktop" ];
      # Directories
      "inode/directory" = [ "thunar.desktop" ];
      # Images
      # "image/jpeg" = [ "feh.desktop" ];
      # "image/png" = [ "feh.desktop" ];
      # "image/gif" = [ "feh.desktop" ];
      # audio
      "audio/mpeg" = [ "vlc.desktop" ];
      "audio/flac" = [ "vlc.desktop" ];
    };
}
