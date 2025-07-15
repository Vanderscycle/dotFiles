{
  pkgs,
  inputs,
  system ? builtins.currentSystem,
  username,
  lib,
  config,
  ...
}:
{
  options = {
    cron.configSync.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables daily dotfiles sync";
      default = false;
    };

    cron.downloadFolderOrganizer.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables daily download files organization";
      default = false;
    };

    cron.dotFile.path = lib.mkOption {
      type = lib.types.str;
      description = "where the dotFiles are located";
      default = "/home/${username}/Documents/dotFiles";
    };
    cron.sshKey = lib.mkOption {
      type = lib.types.str;
      description = "details ssh key to use";
      default = "~/.ssh/endeavourGit";
    };
  };

  config = {
    # pull
    systemd.timers."dotFiles-latest" = lib.mkIf config.cron.configSync.enable {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
        Unit = "dotFiles-latest.service";
      };
    };
    systemd.services."dotFiles-latest" = lib.mkIf config.cron.configSync.enable {
      script = ''
        # cd "${builtins.getEnv "HOME"}/Documents/dotFiles"
        cd ${config.cron.dotFile.path}
        ${pkgs.git}/bin/git status
        eval `ssh-agent -s`
        ssh-add ${config.cron.sshKey}
        ${pkgs.git}/bin/git pull
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

    # download folder org
    systemd.timers."downloadFolderOrganizer" = lib.mkIf config.cron.downloadFolderOrganizer.enable {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
        Unit = "downloadFolderOrganizer.service";
      };
    };
    systemd.services."downloadFolderOrganizer" = lib.mkIf config.cron.downloadFolderOrganizer.enable {
      script = ''
        cd "/home/${username}/Downloads"
        ${pkgs.rsync}/bin/rsync -avz --ignore-existing --remove-source-files *.mkv *.webm *.mp4 ~/Videos/
        ${pkgs.rsync}/bin/rsync -avz --ignore-existing --remove-source-files *.pdf ~/Documents/pdfs
        ${pkgs.rsync}/bin/rsync -avz --ignore-existing --remove-source-files *.png *.jpeg *.webp *.jpg ~/Pictures/
        ${pkgs.rsync}/bin/rsync -avz --ignore-existing --remove-source-files *.3mf *.stl ~/Documents/3d-printing/downloads
      '';
      path = [
        pkgs.rsync
      ];
      serviceConfig = {
        Type = "oneshot";
        User = config.users.users.${username}.name;
      };
    };
  };
}
