{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    program.sqlite.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables sqlite light db";
      default = false;
    };
  };

  config = lib.mkIf config.program.sqlite.enable {
    home = {
      packages = with pkgs; [
        sqlite
      ];
    };
  };
}
