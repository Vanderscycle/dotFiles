{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    plastic_printer.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables 3d printing";
      default = false;
    };
  };

  config = lib.mkIf config.plastic_printer.enable {
    home.packages = with pkgs; [
      # super-slicer-beta
      orca-slicer
    ];
  };
}
