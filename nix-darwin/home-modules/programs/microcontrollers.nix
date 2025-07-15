{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    microcontrollers.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables work with rpi chips";
      default = false;
    };
  };

  config = lib.mkIf config.microcontrollers.enable {
    home = {
      packages = with pkgs; [
        rpi-imager
      ];
    };
  };
}
