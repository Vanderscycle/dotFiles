let
  true_nas_smb = "/mnt/prox-share";
  container_name = "portainer";
in
{
  virtualisation = {
    oci-containers = {
      containers = {
        portainer = {
          image = "portainer/${container_name}-ce:latest";
          volumes = [
            "/var/run/docker.sock:/var/run/docker.sock"
            "${true_nas_smb}/${container_name}:/data"
          ];
          ports = [
            "8000:8000"
            "9443:9443"
          ];
        };
      };
    };
  };
}
