{
  lib,
  config,
  ...
}:
{
  options = {
    program.direnv.enable = lib.mkOption {
      type = lib.types.bool;
      description = "automatic shell entry";
      default = false;
    };
  };

  config = lib.mkIf config.program.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
