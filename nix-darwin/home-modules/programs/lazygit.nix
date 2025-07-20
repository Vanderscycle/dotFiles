{
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.program.git.enable {
    programs.lazygit = {
      enable = true;
    };
    catppuccin.lazygit.enable = true;
  };
}
