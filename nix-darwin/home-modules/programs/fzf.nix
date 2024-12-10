{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    fzf.enable = lib.mkEnableOption "enables fzf completion";
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
