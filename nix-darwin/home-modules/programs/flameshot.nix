{
  lib,
  config,
  ...
}:
{
  options = {
    program.flameshot.enable = lib.mkOption {
      type = lib.types.bool;
      description = "enables screenshots";
      default = false;
    };
  };

  config = lib.mkIf config.program.flameshot.enable {
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
