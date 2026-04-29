{
  den,
  inputs,
  __findFile,
  ...
}:
{
  den.aspects.subutai = {
    includes = [
      (den._.tty-autologin "ilkhan")
      <steppe/boot>
      <steppe/program/docker>
      <steppe/desktop-environment/xfce>
    ];
    nixos =
      { pkgs, ... }:
      {
        imports = with inputs; [
          nixos-hardware.nixosModules.gmktec-nucbox-g3-plus
          nixos-hardware.nixosModules.common-pc-ssd
        ];
        boot = {
          initrd = {
            availableKernelModules = [
              "xhci_pci"
              "ahci"
              "nvme"
              "usbhid"
              "usb_storage"
              "sd_mod"
              "sdhci_pci"
            ];
            kernelModules = [ ];
          };
          kernelModules = [ "kvm-intel" ];
          extraModulePackages = [ ];
        };
        facter.reportPath = ./facter.json;
        environment.systemPackages = with pkgs; [ catppuccin-gtk ];
        time.timeZone = "America/Vancouver";

        hardware = {
          bluetooth.enable = true;
          cpu.intel.updateMicrocode = true;
          enableRedistributableFirmware = true; # Helps with GPU firmware blobs
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
