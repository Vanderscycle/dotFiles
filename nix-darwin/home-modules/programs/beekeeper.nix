{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    program.beekeeper.enable = lib.mkOption {
      type = lib.types.bool;
      description = "enables the best db inspector";
      default = false;
    };
  };
  config =
    lib.mkIf (config.program.beekeeper.enable && pkgs.config.permittedInsecurePackages or false)
      {
        home = {
          packages = with pkgs; [ beekeeper-studio ];
        };
      };
}
