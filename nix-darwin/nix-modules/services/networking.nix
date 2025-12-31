{
  lib,
  config,
  meta,
  ...
}:
{
  options = {
    service.networking.enable = lib.mkOption {
      type = lib.types.bool;
      description = "enables networking";
      default = true;
    };

    service.networking.networkmanager.enable = lib.mkOption {
      type = lib.types.bool;
      description = "enables network manager (doesn't work w/wireless)";
      default = true;
    };

    service.networking.wireless.enable = lib.mkOption {
      type = lib.types.bool;
      description = "enables wireless";
      default = false;
    };

    service.networking.wireless.networks = lib.mkOption {
      type = lib.types.attrsOf (
        lib.types.submodule {
          options = {
            psk = lib.mkOption {
              type = lib.types.str;
              description = "Path to the PSK file or literal PSK string";
            };
          };
        }
      );
      description = "the network";
      default = { };
    };
  };

  config = lib.mkIf config.service.networking.enable {
    users.users.${meta.username} = {
      extraGroups = [
        "networkmanager"
      ];
    };
    networking = {
      networkmanager.enable = config.service.networking.networkmanager.enable;
      wireless = {
        enable = lib.mkForce config.service.networking.wireless.enable;
        networks = config.service.networking.wireless.networks;
      };
      hostName = "${meta.hostname}"; # because we use nh os switch ensure the flakes +
      stevenBlackHosts = {
        enable = true;
        blockFakenews = true;
        blockGambling = true;
      };
    };
  };
}
