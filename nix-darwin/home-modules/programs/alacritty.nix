{
  lib,
  config,
  ...
}:
{
  options = {
    program.alacritty.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables alacritty shell";
      default = false;
    };
  };

  config = lib.mkIf config.program.alacritty.enable {
    home = {
      sessionVariables = {
        TERMINAL = "alacritty";
      };
    };
    programs = {
      alacritty = {
        enable = true;
      };
    };
    catppuccin.alacritty.enable = true;
  };
}
