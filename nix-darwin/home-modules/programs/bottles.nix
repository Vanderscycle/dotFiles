{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    program.bottles.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables bottles for windows app";
      default = false;
    };
  };

  config = lib.mkIf config.program.bottles.enable {
    home = {
      packages = with pkgs; [
        bottles
      ];
      sessionVariables = {
      };
    };
  };
}
