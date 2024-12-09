{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [ transmission_4-gtk ];

  networking.firewall.allowedTCPPorts = [ 57766 ];
}
