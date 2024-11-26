{ self, pkgs,...}:
{
    services.nix-daemon.enable = true;
    nix.settings.experimental-features = "nix-command flakes";
    system.configurationRevision = self.rev or self.dirtyRev or null;
    system.stateVersion = 4;
    nixpkgs.hostPlatform = "aarch64-darwin";
    security.pam.enableSudoTouchIdAuth = true;

    users.users."henri.vandersleyen".home = "/Users/henri.vandersleyen";
    home-manager.backupFileExtension = "backup";
    nix.configureBuildUsers = true;
    nix.useDaemon = true;
    # Homebrew needs to be installed on its own!
    homebrew = {
    enable = true;
    casks = [
    ];
    brews = [
    ];
  };
}
