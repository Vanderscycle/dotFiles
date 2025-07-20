{
  lib,
  config,
  ...
}:
{
  options = {
    program.fzf.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables fzf completion";
      default = true;
    };
  };

  config = lib.mkIf config.program.fzf.enable {
    programs = {
      fzf = {
        enable = true;
      };
    };
    catppuccin.fzf.enable = true;
  };
}
