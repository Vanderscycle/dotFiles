{ pkgs, ... }:
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
  services.xserver = {
    enable = true;

    desktopManager.kodi.enable = true;
    displayManager = {
      autoLogin = {
        enable = true;
        user = "kodi";
      };
      lightdm.autoLogin.timeout = 3;
    };
  };

  users.extraUsers.kodi.isNormalUser = true;
}
