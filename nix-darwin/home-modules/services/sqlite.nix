{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    service.sqlite.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables sqlite light db";
      default = false;
    };
  };

  config = lib.mkIf config.service.sqlite.enable {
    home = {
      packages = with pkgs; [
        sqlite
      ];
    };
  };
}
