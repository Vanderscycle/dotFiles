{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.git.enable {
    programs.lazygit = {
      enable = true;
      catppuccin.enable = true;
    };
  };
}