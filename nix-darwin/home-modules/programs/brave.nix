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
    catppuccin.brave.enable = true;
    home = {
      packages = with pkgs; [
        brave
      ];
      sessionVariables = {
        BROWSER = "brave";
        DEFAULT_BROWSER = "brave";
      };
    };

  };
}
