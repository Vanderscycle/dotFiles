{
  lib,
  config,
  meta,
  ...
}:
{
  options = {
    networking.enable = lib.mkOption {
      type = lib.types.bool;
      description = "enables networking";
      default = true;
    };
  };

  config = lib.mkIf config.networking.enable {
    users.users.${meta.username} = {
      extraGroups = [
        "networkmanager"
      ];
    };
    networking = {
      networkmanager.enable = true;
      hostName = "${meta.hostname}"; # because we use nh os switch ensure the flakes +
      stevenBlackHosts = {
        enable = true;
        blockFakenews = true;
        blockGambling = true;
      };
    };
  };
}
