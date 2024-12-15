{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    thunar.enable = lib.mkOption {
      type = lib.types.bool;
      description = "enables thunar file manager";
      default = false;
    };
  };

  config = lib.mkIf config.thunar.enable {
    home.packages = with pkgs; [
      xfce.thunar
      xfce.tumbler
    ];
  };
}
