{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.kubernetes.enable {
    programs.k9s = {
      enable = true;
    };
    catppuccin.k9s.enable = true;
  };
}
