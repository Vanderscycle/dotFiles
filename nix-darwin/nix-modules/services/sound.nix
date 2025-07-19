{
  pkgs,
  lib,
  config,
  meta,
  ...
}:
{
  options = {
    audio.enable = lib.mkOption {
      type = lib.types.bool;
      description = "enables audio";
      default = true;
    };
  };

  config = lib.mkIf config.audio.enable {
    users.users.${meta.username} = {
      extraGroups = [ "audio" ];
    };

    # Sound settings
    # sound.enable = true;
    services.pulseaudio = {
      enable = false;
      support32Bit = true;
    };
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      wireplumber = {
        enable = true;
      };
    };
  };
}
