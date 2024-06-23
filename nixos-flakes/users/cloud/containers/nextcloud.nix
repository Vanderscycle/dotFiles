let
  true_nas_smb = "/mnt/prox-share";
  container_name = "nextcloud";
in
{
  virtualisation = {
    oci-containers = {
      containers = {
        portainer = {
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
          ports = [ "8443:443" ];
        };
      };
    };
  };
}
