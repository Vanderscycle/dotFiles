{ ... }:
{
  steppe.docker._.lute = {
    nixos = {
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
      homeManager = {
      };
    };
  };
}
