{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    bat.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables bat";
      default = true;
    };
  };
  config = lib.mkIf config.bat.enable {
    programs.bat = {
      enable = true;
    };
    catppuccin.bat.enable = true;
  };
}
