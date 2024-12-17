{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    bluetooth.enable = lib.mkOption {
      type = lib.types.bool;
      description = "enables bluetooth support";
      default = false;
    };
  };

  config = lib.mkIf config.bluetooth.enable {
    # Enable Bluetooth
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = false;
    services.blueman.enable = true;
  };
}
