{
  lib,
  config,
  ...
}:
let
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.modules) mkIf;
  inherit (lib.types) str;
  inherit (lib.types) listOf;
  cfg = config.container.redis;
in
{
  options = {
    container.redis = {
      enable = mkEnableOption "redis container";
      name = mkOption {
        type = str;
        default = "redis";
      };
      mountPoint = mkOption {
        type = str;
        default = "/mnt/rice/docker";
      };
      timezone = mkOption {
        type = str;
        default = "America/Vancouver";
      };
      ports = mkOption {
        type = listOf str;
        default = [ "6379:6379" ];
      };
    };

  };

  config = mkIf cfg.enable {
    virtualisation = {
      oci-containers = {
        backend = "docker";
        containers = {
          redis = {
            image = "${cfg.name}:latest";
            volumes = [ "${cfg.mountPoint}/${cfg.name}/data:/data" ];
            environment = {
              TZ = cfg.timezone;
            };
            ports = cfg.ports;
          };
        };
      };
    };
  };
}
