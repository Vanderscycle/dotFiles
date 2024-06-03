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
  services.xserver = {
    enable = true;

    desktopManager.kodi.enable = true;
    displayManager = {
      autoLogin = {
        enable = true;
        user = hostname;
      };
      lightdm.autoLogin.timeout = 3;
    };
  };

  nix = {
    settings = {
      trusted-users = [ hostname ];
    };
  };
  # users.extraUsers.kodi.isNormalUser = true;
  users = {
    mutableUsers = false;
    users."${hostname}" = {
      isNormalUser = true;
      password = "root";
      shell = pkgs.fish;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMCpHZBybBTCsCyW6/Q4OZ07SvUpRUvclc10u25j0B+Q ${hostname}"
      ];
    };
  };
}
