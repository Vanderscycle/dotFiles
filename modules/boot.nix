{ inputs, lib, ... }:
{
  steppe.boot = {
    nixos = {
      imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

      boot = {
        loader.systemd-boot = {
          enable = lib.mkForce true; # false if useing lanzaboote
          configurationLimit = 10;
        };
        lanzaboote = {
          enable = false;
          pkiBundle = "/var/lib/sbctl";
        };
        # efi.canTouchEfiVariables = true;
        plymouth.enable = true;
        consoleLogLevel = 3;
        initrd.verbose = false;
        initrd.systemd.enable = true;
        kernelParams = [
          "quiet"
          "splash"
          "intremap=on"
          "boot.shell_on_fail"
          "udev.log_priority=3"
          "rd.systemd.show_status=auto"
        ];
      };

    };
  };
}
