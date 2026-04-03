{
  lib,
  config,
  meta,
  ...
}:
{
  options = {
    program.networking.enable = lib.mkOption {
      type = lib.types.bool;
      description = "enables networking";
      default = true;
    };

    program.networking.networkmanager.enable = lib.mkOption {
      type = lib.types.bool;
      description = "enables network manager (doesn't work w/wireless)";
      default = true;
    };

    program.networking.wireless.enable = lib.mkOption {
      type = lib.types.bool;
      description = "enables wireless";
      default = false;
    };

    program.networking.wireless.networks = lib.mkOption {
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

  config = lib.mkIf config.program.networking.enable {
    users.users.${meta.username} = {
      extraGroups = [
        "networkmanager"
      ];
    };
    networking = {
      networkmanager.enable = config.program.networking.networkmanager.enable;
      wireless = {
        enable = lib.mkForce config.program.networking.wireless.enable;
        networks = config.program.networking.wireless.networks;
      };
      hostName = "${meta.hostname}"; # because we use nh os switch ensure the flakes +
    };
  };
}
