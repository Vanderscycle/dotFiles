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
  container_name = "protonmail-bridge";
in
{
  options = {
    container.protonmail-bridge.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables protonmail bridge container";
      default = false;
    };

    config = lib.mkIf config.container.protonmail-bridge.enable {
      virtualisation = {
        oci-containers = {
          backend = "docker";
          containers = {
            # sudo chmod -R 755 /mnt/prox-share/n8n
            n8n = {
              image = "shenxn//${container_name}:latest";
              volumes = [ "${true_nas_smb}/${container_name}:/root" ];
              environment = {
                PUID = "1000";
                PGID = "1000";
                TZ = "America/Vancouver";
              };
              ports = [ "1143:143" ];
            };
          };
        };
      };
    };
  };
}
