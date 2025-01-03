{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    btop.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables btop";
      default = true;
    };
  };
  config = lib.mkIf config.btop.enable {
    programs.btop = {
      enable = true;
      settings = {
        theme_background = true;
      };
    };
    catppuccin.btop.enable = true;
  };
}
