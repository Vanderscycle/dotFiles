{
  lib,
  config,
  ...
}:
{
  options = {
    program.syncthing.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables the best cli";
      default = true;
    };
  };

  config = lib.mkIf config.program.syncthing.enable {
    services.syncthing = {
      enable = true;
    };
  };
}
