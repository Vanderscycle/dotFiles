{
  lib,
  meta,
  inputs,
  pkgs,
  config,
  ...
}:
{

  options = {
    cron.systemUpdates.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables daily updates + pull";
      default = false;
    };
  };

  config = lib.mkIf config.systemUpdates.enable {
    system.autoUpgrade = {
      enable = true;
      upgrade = false; # keep lockfile
      allowReboot = false;
      runGarbageCollection = true;
      # flake = "github:vanderscycle/monolith"; # not really working for me (its private)
      flake = inputs.self.outPath;
      flags = [
        "--impure"
        "--refresh"
        "--print-build-logs"
      ];
      dates = "daily";
      randomizedDelaySec = "45min";
    };

    # 2. The "Git Pull" Service
    systemd.services.nixos-repo-pull = {
      description = "Pull latest NixOS config from GitHub";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      before = [ "nixos-upgrade.service" ]; # Ensure pull happens BEFORE upgrade
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "oneshot";
        User = meta.username;
      };

      path = [
        pkgs.git
      ];
      script = ''
        # Ensure the directory exists and is a git repo
        if [ ! -d /home/${meta.username}/Documents/${meta.username}/.git ]; then
          echo -e "pull the repo"
          git clone https://github.com/Vanderscycle/monolith.git /home/${meta.username}/Documents/
        else
          echo -e "repo exists"
        fi

        cd /home/${meta.username}/Documents/${meta.username}/
        git pull origin main
      '';
    };

    # 3. Trigger the Pull when the Upgrade starts
    systemd.timers.nixos-upgrade.timerConfig.Persistent = true;
  };
}
