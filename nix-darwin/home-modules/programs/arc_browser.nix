{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    arc-browser.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables the arc-browser";
      default = false;
    };
  };

  config = lib.mkIf config.arc-browser.enable {
    # Merge the packages conditionally
    home.packages = with pkgs; [
      arc-browser
    ];
  };
}
