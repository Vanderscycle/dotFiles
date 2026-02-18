{
  lib,
  config,
  ...
}:
{
  options.container.lute.enable = lib.mkOption {
    type = lib.types.bool;
    description = "Enables lute language learning";
    default = false;
  };

  config = lib.mkIf config.container.lute.enable {
    virtualisation.oci-containers = {
      backend = "docker";
      containers.lute = {
        image = "jzohrab/lute3:latest";
        volumes = [
          "/mnt/backup/lute/data:/lute_data"
          "/mnt/backup/lute:/lute_backup"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Vancouver";
        };
        ports = [ "5001:5001" ];
      };
    };
  };
}
