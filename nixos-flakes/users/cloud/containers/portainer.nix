{
  virtualisation = {
    oci-containers = {
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
        };
      };
  };
}
