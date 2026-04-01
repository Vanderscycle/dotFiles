{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    hardware.moonlander.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables moonlander wally program";
      default = false;
    };
  };
  config = lib.mkIf config.hardware.moonlander.enable {
    environment.systemPackages = with pkgs; [
      wally-cli
      keymapp
    ];
  };
}
