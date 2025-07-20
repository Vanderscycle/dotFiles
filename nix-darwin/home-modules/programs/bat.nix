{
  lib,
  config,
  ...
}:
{
  options = {
    program.bat.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables bat";
      default = true;
    };
  };
  config = lib.mkIf config.program.bat.enable {
    programs.bat = {
      enable = true;
    };
    catppuccin.bat.enable = true;
  };
}
