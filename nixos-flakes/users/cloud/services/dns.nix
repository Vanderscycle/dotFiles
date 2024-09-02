{ pkgs, ... }:
{
  services.dnsmasq = {
    enable = true;
    extraConfig = ''
      address=/nas.home.dev/192.168.1.243
    '';
  };
}
