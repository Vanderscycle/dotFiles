{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    program.bluetooth.enable = lib.mkOption {
      type = lib.types.bool;
      description = "enables bluetooth support";
      default = false;
    };
  };

  config = lib.mkIf config.program.bluetooth.enable {
    environment.systemPackages = [
      pkgs.bluez
    ];
    hardware.bluetooth.enable = true;
    hardware.xpadneo.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    services.blueman.enable = true;

  };
}
