{ lib, pkgs, ... }:
let
  fileZone = pkgs.writeText "h.zone" ''
    $ORIGIN home.dev.
    @       IN SOA ns.home.dev. nomail.home.dev. (
            1         ; Version number
            60        ; Zone refresh interval
            30        ; Zone update retry timeout
            180       ; Zone TTL
            3600)     ; Negative response TTL

    h. IN NS ns.home.dev.

    ns 180 IN A 192.168.1.157

    ; hosts
    nas.home.dev. 180 IN A 192.168.1.157

    ; alias
    storage.home.dev. 180 IN A 192.168.1.157
  '';
in
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
          file ${fileZone}
          log
        }

    '';
  };
}
