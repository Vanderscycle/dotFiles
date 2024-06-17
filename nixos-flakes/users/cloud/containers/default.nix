{ username, ... }:
{
  virtualisation = {
    oci-containers = {
      backend = "docker";
      containers = {
        portainer = {
          image = "portainer/portainer-ce:latest";
          volumes = [
            "/var/run/docker.sock:/var/run/docker.sock"
            "/data/portainer:/data"
          ];
          ports = [
            "8000:8000"
            "9443:9443"
          ];
          restartPolicy = "always";
        };
      };
      # containers = {
      #   prusaslicer-novnc = {
      #     image = "mikeah/prusaslicer-novnc:latest";
      #     volumes = [ "/home/${username}/Documents/3D-models:/data" ];
      #     ports = [ "4243:8080" ];
      #   };
      #   orcaslicer = {
      #     image = "lscr.io/linuxserver/orcaslicer:latest";
      #     volumes = [ "/path/to/config:/config" ];
      #     environment = {
      #       PUID = "1000";
      #       PGID = "1000";
      #       TZ = "Etc/UTC";
      #     };
      #     ports = [
      #       "3000:3000"
      #       "3001:3001"
      #     ];
      #   };
      # };
    };
  };
}
