{ hostname, ... }:
{
  imports = [
    ./${hostname}
    ./internationalisation
  ];
}
