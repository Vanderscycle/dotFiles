{ pkgs, ... }:

{
  # Enable the CUPS printing service
  services.printing.enable = true;

  networking.firewall.allowedTCPPorts = [ 631 ]; # CUPS usually runs on port 631
}
