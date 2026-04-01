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
      default = false;
    };
  };

  config = lib.mkIf config.program.syncthing.enable {
    services.syncthing = {
      enable = true;
    };
  };
}
