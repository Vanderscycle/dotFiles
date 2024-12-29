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
  container_name = "nextcloud";
in
{
  options = {
    container.nextcloud.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables nextcloud container";
      default = false;
    };

    config = lib.mkIf config.container.nextcloud.enable {
  virtualisation = {
    oci-containers = {
      backend = "docker";
      containers = {
        nextcloud = {
          image = "lscr.io/linuxserver/${container_name}:latest";
          volumes = [
            "${true_nas_smb}/${container_name}/config:/config"
            "${true_nas_smb}/${container_name}/data:/data"
          ];
          environment = {
            PUID = "1000";
            PGID = "1000";
            TZ = "America/Vancouver";
          };
          ports = [ "8080:80" ];
        };
      };
      };
    };
  };
}
