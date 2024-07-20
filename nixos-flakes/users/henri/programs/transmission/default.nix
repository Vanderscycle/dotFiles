{
  username,
  pkgs,
  system,
  ...
}:
{
  # environment.systemPackages = with pkgs; [ transmission-gtk ];

  networking.firewall.allowedTCPPorts = [ 57766 ];
}
