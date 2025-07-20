{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    program.brave.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables chromium based brave browser";
      default = false;
    };
  };

  config = lib.mkIf config.program.brave.enable {
    home.packages = with pkgs; [
      brave
    ];
  };
}
