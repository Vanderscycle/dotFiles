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
  container_name = "n8n";
in
{
  options = {
    container.n8n.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables n8n container";
      default = false;
    };

    config = lib.mkIf config.container.n8n.enable {
      virtualisation = {
        oci-containers = {
          backend = "docker";
          containers = {
            # sudo chmod -R 755 /mnt/prox-share/n8n
            n8n = {
              image = "docker.n8n.io/n8nio/${container_name}:latest";
              volumes = [ "${true_nas_smb}/${container_name}:/home/node/.n8n" ];
              environment = {
                PUID = "1000";
                PGID = "1000";
                TZ = "America/Vancouver";
                N8N_SECURE_COOKIE = "false";
              };
              ports = [ "5678:5678" ];
            };
          };
        };
      };
    };
  };
}
