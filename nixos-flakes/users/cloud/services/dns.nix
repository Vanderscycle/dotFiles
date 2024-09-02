{ pkgs, ... }:
{
  services.dnsmasq = {
    enable = true;
    extraConfig = ''
      address=/nas.home.dev/92.168.1.157:80
    '';
  };
}
