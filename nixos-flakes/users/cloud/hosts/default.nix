{ hostname, ... }:
{
  imports = [
    ./${hostname}
    ../../../hosts/internationalisation
    ../../../hosts/hardware
  ];

  hardware.cpu.amd.updateMicrocode = true;
}
