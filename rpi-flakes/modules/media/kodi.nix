{ pkgs, hostname, ... }:
{
  environment.systemPackages = with pkgs; [
    libreelec-dvb-firmware
    kodi
    (pkgs.kodi.passthru.withPackages (
      kodiPkgs: with kodiPkgs; [
        jellyfin
        youtube
      ]
    ))
  ];
  networking.firewall = {
    allowedTCPPorts = [
      22
      8080
    ];
    allowedUDPPorts = [
      22
      8080
    ];
  };

  services = {
    displayManager = {
      autoLogin = {
        enable = true;
        user = hostname;
      };
      xserver = {
        enable = true;
        desktopManager.kodi = {
          enable = true;
          package = pkgs.kodi;
        };
      };
    };
  };
  nix = {
    settings = {
      trusted-users = [ hostname ];
    };
  };
}
