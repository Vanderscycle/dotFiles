let
  true_nas_smb = "/mnt/prox-share";
  container_name = "homeassistant";
in
{
  virtualisation = {
    oci-containers = {
      containers = {
        homeassistant = {
          image = "linuxserver/${container_name}:2024.6.3";
          environment = {
            TZ = "America/Vancouver"; # Specify a timezone to use
            PUID = "1000"; # User ID to run as
            PGID = "1000"; # Group ID to run as
          };
          ports = [ "8123:8123" ];
          volumes = [
            "${true_nas_smb}/${container_name}:/config" # Contains all relevant configuration files
          ];
        };
      };
    };
  };
}
