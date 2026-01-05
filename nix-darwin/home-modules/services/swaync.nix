{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    service.swaync.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables swaync message control";
      default = false;
    };
  };

  config = lib.mkIf config.service.swaync.enable {
    catppuccin.swaync.enable = true;
    services.swaync = {
      enable = true;
      package = pkgs.swaynotificationcenter;
      # settings = {
      # };
      # style = {
      # };
    };
  };
}
