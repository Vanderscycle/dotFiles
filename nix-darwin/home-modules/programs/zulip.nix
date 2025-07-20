{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    program.zulip.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables ghost/slack communication";
      default = false;
    };
  };

  config = lib.mkIf config.program.zulip.enable {
    home = {
      packages = with pkgs; [
        zulip
      ];
    };
  };
}
