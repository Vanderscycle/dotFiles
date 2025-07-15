{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    transmission.enable = lib.mkOption {
      type = lib.types.bool;
      description = "enables p2p sharing";
      default = false;
    };
  };

  config = lib.mkIf config.transmission.enable {
    environment.systemPackages = with pkgs; [ transmission_4-gtk ];
    networking.firewall.allowedTCPPorts = [ 57766 ];
  };
}
