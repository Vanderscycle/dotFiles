{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    fuzzel.enable = lib.mkEnableOption "enables fuzzel program launcher";
  };
  config = lib.mkIf config.fuzzel.enable {
    programs = {
      # https://codeberg.org/dnkl/fuzzel?ref=mark.stosberg.com
      fuzzel = {
        enable = true;
      };
    };
  };
}
