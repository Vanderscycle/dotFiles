{ ... }:
{
  steppe.program._.automount = {
    homeManager = {
    };
    nixos =
      { pkgs, ... }:
      {
        services.autofs = {
          enable = true;
          autoMaster = ''
            /mnt/usb /etc/auto.usb --timeout=60 --ghost
          '';
        };

        environment.etc."auto.usb".text = ''
          * -fstype=auto,rw,user,gid=100,umask=002 :/dev/&
        '';
      };
  };
}
