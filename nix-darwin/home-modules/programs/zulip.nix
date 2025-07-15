{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    zulip.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables ghost/slack communication";
      default = false;
    };
  };

  config = lib.mkIf config.zulip.enable {
    home = {
      packages = with pkgs; [
        zulip
      ];
    };
  };
}
