{
  lib,
  config,
  ...
}:
{
  options = {
    program.fuzzel.enable = lib.mkOption {
      type = lib.types.bool;
      description = "enables fuzzel program launcher";
      default = false;
    };
  };

  config = lib.mkIf config.program.fuzzel.enable {
    programs = {
      # https://codeberg.org/dnkl/fuzzel?ref=mark.stosberg.com
      fuzzel = {
        enable = true;
      };
    };
  };
}
