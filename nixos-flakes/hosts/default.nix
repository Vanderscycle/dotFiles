{ hostname, ... }:
{
  imports = [
    ./${hostname}
    ./internationalisation
  ];
}