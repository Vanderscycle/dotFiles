{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    printer.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables printing";
      default = false;
    };
  };
  config = lib.mkIf config.printer.enable {
    # Enable the CUPS printing service
    services.printing.enable = true;

    networking.firewall.allowedTCPPorts = [ 631 ]; # CUPS usually runs on port 631
  };
}
