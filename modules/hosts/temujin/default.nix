{
  den,
  inputs,
  __findFile,
  ...
}:
{
  den.aspects.temujin = {
    includes = [
      (den._.tty-autologin "khan")
      <steppe/program/zsa>
      <steppe/boot>
      <steppe/gtk>
      <steppe/program/docker>
      <steppe/gaming>
    ];
    nixos =
      { pkgs, ... }:
      {
        imports = with inputs; [
          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-gpu-amd
          nixos-hardware.nixosModules.common-pc-ssd
        ];
        boot.initrd.kernelModules = [ "amdgpu" ];
        services.xserver.videoDrivers = [ "amdgpu" ];
        hardware = {
          cpu.amd.updateMicrocode = true;
          enableRedistributableFirmware = true; # Helps with GPU firmware blobs
        };
        facter.reportPath = ./facter.json;
        environment.systemPackages = [ ];
        time.timeZone = "America/Vancouver";

        hardware = {
          amdgpu.opencl.enable = true;
          bluetooth.enable = true;
        };
        virtualisation.vmVariant = {
          # These settings only apply when building the VM, not the host
          virtualisation = {
            memorySize = 8192;
            cores = 4;
            graphics = true;
          };
        };
      };
  };
}
