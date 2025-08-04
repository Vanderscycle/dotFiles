{
  pkgs,
  inputs,
  system ? builtins.currentSystem,
  meta,
  lib,
  config,
  ...
}:
{
  options = {
    cron.nasBackup.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables daily nas sync";
      default = false;
    };

    cron.nasBackup.photos.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables daily nas sync";
      default = false;
    };
  };

  config = {
    systemd.timers."nas-photos-save" = lib.mkIf config.cron.nasBackup.photos.enable {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
        Unit = "nas-photos-save.service";
      };
    };

    systemd.services."nas-photos-save" = lib.mkIf config.cron.nasBackup.photos.enable {
      script = ''
        ${pkgs.rsync}/bin/rsync -avz /mnt/rice/nextcloud/Photos /mnt/backup/photos/nas
      '';
      path = with pkgs; [
        coreutils
      ];
      serviceConfig = {
        Type = "oneshot";
        user = "root";
        # User = config.users.users.${meta.username}.name;
      };
    };
  };
}
