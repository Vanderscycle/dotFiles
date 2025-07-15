{
  pkgs,
  lib,
  config,
  username,
  hostname,
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
    users.users.${username} = {
      extraGroups = [
        "networkmanager"
      ];
    };
    networking = {
      networkmanager.enable = true;
      hostName = "${hostname}"; # because we use nh os switch ensure the flakes +
      stevenBlackHosts = {
        enable = true;
        blockFakenews = true;
        blockGambling = true;
      };
    };
  };
}
