{ hostname, ... }:
{
  imports = [
    ./${hostname}
    ./internationalisation
    ./hardware
  ];
}
