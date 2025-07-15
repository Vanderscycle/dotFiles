{ config, lib, ... }:
{
  options = {
    service.transmission.enable = lib.mkOption {
      type = lib.types.bool;
      description = "torrent service";
      default = false;
    };
  };

  config = lib.mkIf config.service.transmission.enable {
    services.transmission = {
      enable = true;
      openFirewall = false; # INFO: we use traefik
      openPeerPorts = true;
      settings = {
        rpc-port = 9091;
        rpc-bind-address = "0.0.0.0"; # fix typo: rpc-bind-addres -> rpc-bind-address
        rpc-host-whitelist = "transmission.homecloud.lan,localhost,127.0.0.1";
        rpc-host-whitelist-enabled = true;
        download-dir = "/mnt/transmission";
        incomplete-dir = "/mnt/transmission";
        download-queue-enabled = true;
        download-queue-size = 15;
      };
    };
  };
}
