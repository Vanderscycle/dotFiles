let
  true_nas_smb = "/mnt/prox-share";
  container_name = "transmission";
in
{
  virtualisation = {
    oci-containers = {
      containers = {
        transmission = {
          image = "lscr.io/linuxserver/${container_name}:latest";
          ports = [
            "9091:9091"
            "51413:51413"
            "51413:51413/udp"
          ];
          volumes = [
            "${true_nas_smb}/${container_name}/config:/config"
            "${true_nas_smb}/${container_name}/downloads:/downloads"
            "${true_nas_smb}/${container_name}/watch:/watch"
          ];
          environment = {
            PUID = "1000";
            PGID = "1000";
            TZ = "America/Vancouver";
          };
        };
      };
    };
  };
}
