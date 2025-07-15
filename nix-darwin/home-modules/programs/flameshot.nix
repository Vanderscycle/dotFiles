{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    flameshot.enable = lib.mkOption {
      type = lib.types.bool;
      description = "enables screenshots";
      default = false;
    };
  };

  config = lib.mkIf config.flameshot.enable {
    services = {
      flameshot = {
        enable = true;
        settings = {
          General = {
            showStartupLaunchMessage = false;
          };
        };
      };
    };
  };
}
