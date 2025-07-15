{ lib, config, ... }:

let
  cfg = config.container.nginx;
in
{
  options = {
    container.nginx = {
      enable = lib.mkEnableOption "nginx container";
      name = lib.mkOption {
        type = lib.types.str;
        default = "nginx";
      };
      mountPoint = lib.mkOption {
        type = lib.types.str;
        default = "/tmp/nginx";
      };
      ports = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ "8080:80" ];
      };
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation = {
      oci-containers = {
        backend = "docker";
        containers = {
          nginx = {
            image = "nginx:latest";
            volumes = [
              "${cfg.mountPoint}/html:/usr/share/nginx/html"
              "${cfg.mountPoint}/conf:/etc/nginx/conf.d"
            ];
            ports = cfg.ports;
          };
        };
      };
    };
  };
}
