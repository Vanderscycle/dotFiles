let
  true_nas_smb = "/mnt/prox-share";
in
{
  virtualisation = {
    oci-containers = {
      containers = {
        transmission = {
          image = "lscr.io/linuxserver/transmission:latest";
          name = "transmission";
          ports = [
            "9091:9091"
            "51413:51413"
            "51413:51413/udp"
          ];
          volumes = [
            "${true_nas_smb}/config:/config"
            "${true_nas_smb}/downloads:/downloads"
            "${true_nas_smb}/watch:/watch"
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
