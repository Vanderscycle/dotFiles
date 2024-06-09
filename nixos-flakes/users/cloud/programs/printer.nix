{ pkgs, ... }:

{
  # Enable the CUPS printing service
  services.printing.enable = true;

  # environment.systemPackages = with pkgs; [
  #   hplip # HP Linux Imaging and Printing - for HP printers
  # ];

  networking.firewall.allowedTCPPorts = [ 631 ]; # CUPS usually runs on port 631

  # services.avahi = {
  #   enable = true;
  #   nssmdns = true;
  # };
}
