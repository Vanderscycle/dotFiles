{
  steppe,
  __findFile,
  ...
}:
{
  steppe.gui = {
    includes = [
      <steppe/program/cad>
      <steppe/program/libreoffice>
      <steppe/program/multimedia>
      <steppe/program/communications>
      <steppe/program/beekeeper>
    ];
    nixos = { };
    homeManager = { };
  };
}
