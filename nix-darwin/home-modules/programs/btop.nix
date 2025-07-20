{
  lib,
  config,
  ...
}:
{
  options = {
    program.btop.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables btop";
      default = true;
    };
  };
  config = lib.mkIf config.program.btop.enable {
    programs.btop = {
      enable = true;
      settings = {
        theme_background = true;
      };
    };
    catppuccin.btop.enable = true;
  };
}
