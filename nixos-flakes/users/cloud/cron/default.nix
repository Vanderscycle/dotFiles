{ username, pkgs, ... }:
{
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 0 0 * * 1       ${username} cd $HOME/dotFiles & ${pkgs.git} pull && ${pkgs.bash}/bin/bash -c 'nh os switch'"
    ];
  };

  systemd.services."dotFiles-latest" = {
    script = ''
      cd $HOME/dotFiles
      ${pkgs.git}/bin/git pull
      ${pkgs.bash}/bin/bash -c 'nh os switch'
    '';
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };
}
