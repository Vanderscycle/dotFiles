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
    cron.factorioSave.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables daily dotfiles sync";
      default = false;
    };
  };

  config = {
    systemd.timers."factorio-save" = lib.mkIf config.cron.factorioSave.enable {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
        Unit = "factorio-save.service";
      };
    };

    # WARN: NOT WORKING
    systemd.services."factorio-save" = lib.mkIf config.cron.factorioSave.enable {
      script = ''
        ${pkgs.rsync}/bin/rsync -e "${pkgs.openssh}/bin/ssh -i /home/henri/.ssh/endeavourGit" \
          -avz root@192.168.4.250:/home/fctrserver/serverfiles/save1.zip /home/henri/Documents/factorioServer
      '';
      path = with pkgs; [
        rsync
        openssh
        coreutils
        keychain
      ];
      serviceConfig = {
        Type = "oneshot";
        User = config.users.users.${username}.name;
      };
    };
  };
}
