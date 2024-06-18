let
  true_nas_smb = "/mnt/prox-share";
in
{
  virtualisation = {
    oci-containers = {
      containers = {
        homeassistant = {
          image = "linuxserver/homeassistant:2024.6.3";
          name = "homeassistant";
          net = "host";
          environment = {
            TZ = "America/Vancouver"; # Specify a timezone to use
            PUID = "1000"; # User ID to run as
            PGID = "1000"; # Group ID to run as
          };
          volumes = [
            "${true_nas_smb}:/config" # Contains all relevant configuration files
          ];
          devices = [ ];
        };
      };
    };
  };
}
