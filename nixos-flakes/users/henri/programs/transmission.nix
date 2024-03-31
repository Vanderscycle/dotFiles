{username, pkgs, ...}:
{
  environment.systemPackages = with pkgs;[
    transmission-gtk
  ];
  services.transmission = {
    enable = true; #Enable transmission daemon
    settings = {
      #Override default settings

      download-dir = "/home/${username}/Transmission";
      # incomplete-dir = "/mnt/backup/transmission ";
    };
  };
}
