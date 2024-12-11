{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    fzf.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables fzf completion";
      default = true;
    };
  };

  config = lib.mkIf config.fzf.enable {
    programs = {
      fzf = {
        enable = true;
        catppuccin.enable = true;
      };
    };
  };
}
