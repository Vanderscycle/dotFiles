{ username, pkgs, ... }:
{
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 0 0 * * 1       ${username} cd $HOME/dotFiles & ${pkgs.git} pull && ${pkgs.bash}/bin/bash -c 'nh os switch'"
    ];
  };

}
