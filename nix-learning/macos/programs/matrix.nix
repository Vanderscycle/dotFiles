{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    steam-loco.enable = lib.mkOption {
      type = lib.types.bool;
      description = "welcome neo";
      default = false;
    };
  };

  config = lib.mkIf config.steam-loco.enable {
    home.packages = with pkgs; [
      sl
    ];
  };
}
