{ pkgs, meta, ... }:
{
  #TODO: change for nas photos. make it rsync
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
}
