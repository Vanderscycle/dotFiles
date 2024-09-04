{ lib, pkgs, ... }:
{
  networking.firewall = {
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [ 53 ];
  };

  services.coredns = {
    enable = true;
    config = ''
      . {
          forward . 9.9.9.9
          cache
          log
        }

      home.dev {
          hosts {
              192.168.1.168 proxmox.home.dev
              fallthrough
          }
      }
    '';
  };

}
