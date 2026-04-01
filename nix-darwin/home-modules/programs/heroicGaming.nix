{
  lib,
  pkgs,
  config,
  ...
}:
{
  options = {
    program.gaming.heroic.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables heroic game launcher";
      default = false;
    };
  };
  config = lib.mkIf config.program.gaming.heroic.enable {
    home = {
      packages = with pkgs; [ heroic ];
    };
  };
}
