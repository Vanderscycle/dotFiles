{
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
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    boot.extraModulePackages = with config.boot.kernelPackages; [ xpadneo ];
    services.blueman.enable = true;

    services.udev.extraRules = ''
      # Enable Xbox controller support via Bluetooth
      SUBSYSTEM=="input", GROUP="input", MODE="0660"
      KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
    '';
  };
}
