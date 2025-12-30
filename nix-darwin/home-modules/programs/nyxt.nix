{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    program.nyxt.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables chromium based nyxt browser";
      default = false;
    };
  };

  config = lib.mkIf config.program.nyxt.enable {
    home = {
      packages = with pkgs; [
        nyxt
      ];
      sessionVariables = {
        # BROWSER = "nyxt";
        # DEFAULT_BROWSER = "nyxt";
      };
    };

  };
}
