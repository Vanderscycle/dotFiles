{ config, lib, ... }:
{
  options = {
    service.n8n.enable = lib.mkOption {
      type = lib.types.bool;
      description = "automation service";
      default = false;
    };
  };

  config = lib.mkIf config.service.n8n.enable {
    services.n8n = {
      enable = true;
      openFirewall = true;
      settings = {
      };
    };
    #INFO: a way to set env vars for services
    systemd.services.n8n.environment = {
      N8N_SECURE_COOKIE = "false";
      N8N_LISTEN_ADDRESS = "0.0.0.0";
      N8N_METRICS = "true"; # prometheus
    };

    services.prometheus = {
      scrapeConfigs = [
        {
          job_name = "n8n";
          static_configs = [
            {
              targets = [ "n8n.homecloud.lan" ];
            }
          ];
        }
      ];
    };
  };
}
