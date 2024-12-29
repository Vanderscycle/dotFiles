{
  pkgs,
  inputs,
  system ? builtins.currentSystem,
  username,
  lib,
  config,
  ...
}:
let
  true_nas_smb = "/mnt/rice/docker";
  container_name = "redis";
in
{
  options = {
    container.redis.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables a Redis container";
      default = false;
    };
  };

  config = lib.mkIf config.container.redis.enable {
    virtualisation = {
      oci-containers = {
        backend = "docker";
        containers = {
          redis = {
            image = "redis:latest";
            volumes = [
              "${true_nas_smb}/${container_name}/data:/data"
            ];
            environment = {
              TZ = "America/Vancouver";
            };
            ports = [ "6379:6379" ];
          };
        };
      };
    };
  };
}
