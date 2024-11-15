{ hostname, ... }:
{
  imports = [
    ./${hostname}
    ../../hosts/internationalisation
    ../../hosts/hardware
  ];
}
