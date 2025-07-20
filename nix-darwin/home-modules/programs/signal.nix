{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    program.signal.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables ghost communication";
      default = false;
    };
  };

  config = lib.mkIf config.program.signal.enable {
    home = {
      packages = with pkgs; [
        signal-desktop
      ];
    };
  };
}
