{username, pkgs, ...}:
{
  environment.systemPackages = with pkgs;[
    transmission-gtk
  ];

  networking.firewall.allowedTCPPorts = [ 57766 ];
  services.transmission = {
    enable = true; #Enable transmission daemon
    settings = {
      #Override default settings

      download-dir = "/home/${username}/Transmission";
      # incomplete-dir = "/mnt/backup/transmission ";
    };
  };
}
