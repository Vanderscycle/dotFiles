{ username,config, pkgs, ... }:
{
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 0 0 * * 1       ${username} cd $HOME/dotFiles & ${pkgs.git} pull && ${pkgs.bash}/bin/bash -c 'nh os switch'"
    ];
  };

systemd.timers."dotFiles-latest" = {
  wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true; 
      Unit = "dotFiles-latest.service";
    };
};
  systemd.services."dotFiles-latest" = {
    script = ''
      # cd "${builtins.getEnv "HOME"}/Documents/dotFiles"
      cd "/home/${username}/Documents/dotFiles/nixos-flakes"
      ${pkgs.git}/bin/git status
      eval `ssh-agent -s`
      ssh-add ~/.ssh/endeavourGit
      ${pkgs.git}/bin/git pull
      # sudo nixos-rebuild switch --flake ".#cloud"
    '';
      path = [
        pkgs.openssh
        pkgs.git
      ];
  serviceConfig = {
    Type = "oneshot";
    User = config.users.users.${username}.name;
  };
  };
}
