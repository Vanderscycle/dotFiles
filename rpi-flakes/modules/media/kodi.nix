{ pkgs, hostname, ... }:
{
  environment.systemPackages = with pkgs; [
    libreelec-dvb-firmware
    kodi
    (pkgs.kodi.passthru.withPackages (kodiPkgs: with kodiPkgs; [ jellyfin ]))
  ];
  networking.firewall = {
    allowedTCPPorts = [ 8080 ];
    allowedUDPPorts = [ 8080 ];
  };

  services = {
    displayManager = {
      autoLogin = {
        enable = true;
        user = hostname;
      };
      xserver = {
        enable = true;
        desktopManager.kodi.enable = true;
        lightdm.autoLogin.timeout = 3;
      };
    };
  };
  nix = {
    settings = {
      trusted-users = [ hostname ];
    };
  };
}
