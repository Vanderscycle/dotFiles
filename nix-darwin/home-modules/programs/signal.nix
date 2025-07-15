{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    signal.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables ghost communication";
      default = false;
    };
  };

  config = lib.mkIf config.signal.enable {
    home = {
      packages = with pkgs; [
        signal-desktop
      ];
    };
  };
}
