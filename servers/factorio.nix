{
  config,
  lib,
  pkgs,
  meta,
  ...
}:
{
  options = {
    server.factorio.enable = lib.mkOption {
      type = lib.types.bool;
      description = "media service";
      default = false;
    };
  };

  config = lib.mkIf config.server.factorio.enable {
    systemd.tmpfiles.rules = [
      # Copy/Link the save file (use either C or L)
      "C /var/lib/factorio/saves/save1.zip - - - - ${builtins.path { path = ./save1.zip; }}"
    ];
    systemd.timers."factorioSaves" = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
        Unit = "factorioSaves.service";
      };
    };

    systemd.services."factorioSaves" = {
      script = ''
        cd "/var/lib/factorio/saves/"
        DATE=$(date +%F)
        ${pkgs.rsync}/bin/rsync -avz save1.zip "/home/${meta.username}/Saves/save1-$DATE.zip"
      '';
      path = [
        pkgs.rsync
        pkgs.coreutils # for `date`
      ];
      serviceConfig = {
        Type = "oneshot";
        User = "root";
      };
    };

    services.factorio = {
      bind = "192.168.4.129";
      package = pkgs.factorio-headless.override (oldAttrs: {
        versionsJson = ./versions.json;
        username = builtins.readFile config.sops.secrets."factorio/admin".path;
        token = builtins.readFile config.sops.secrets."factorio/token".path;
      });
      enable = true;
      public = true;
      username = builtins.readFile config.sops.secrets."factorio/admin".path;
      token = builtins.readFile config.sops.secrets."factorio/token".path;
      openFirewall = true;
      stateDirName = "factorio";
      extraSettingsFile = pkgs.writeText "server-settings.json" (
        builtins.toJSON {
          game_password = builtins.readFile config.sops.secrets."factorio/game-password".path;
        }
      );
      extraSettings = {
        max_players = 16;
      };
      autosave-interval = 20;
      saveName = "save1";
      game-name = "[NixOs] factorio";
      description = "Factorio on nixos";
      admins = [
        (builtins.readFile config.sops.secrets."factorio/admin".path)
      ];
    };
  };
}
