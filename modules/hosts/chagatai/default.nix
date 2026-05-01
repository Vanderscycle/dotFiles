{
  den,
  inputs,
  __findFile,
  ...
}:
{
  den.aspects.chagatai = {
    includes = [
      (den._.tty-autologin "ilkhan")
      <steppe/boot>
      <steppe/program/docker>
    ];
    nixos =
      { pkgs, ... }:
      {
        imports = with inputs; [
          nixos-hardware.nixosModules.common-pc-ssd
        ];
        boot = {
          initrd = {
            availableKernelModules = [
              "uhci_hcd"
              "ehci_pci"
              "ahci"
              "virtio_pci"
              "virtio_scsi"
              "sd_mod"
              "sr_mod"
            ];
            kernelModules = [ ];
          };
          kernelModules = [ ];
          extraModulePackages = [ ];
        };
        facter.reportPath = ./facter.json;
        environment.systemPackages = with pkgs; [ ];
        time.timeZone = "America/Vancouver";

        hardware = {
        };

        services = {
          openssh = {
            enable = true;
          };
        };
        virtualisation.vmVariant = {
          virtualisation = {
            memorySize = 8192;
            cores = 4;
            graphics = true;
          };
        };
      };
  };
}
