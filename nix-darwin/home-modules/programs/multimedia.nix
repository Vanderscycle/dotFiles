{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    program.multimedia.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables multimedia";
      default = true;
    };
  };

  config = lib.mkIf config.program.multimedia.enable {
    home = {
      packages = with pkgs; [
        ytfzf
        vlc # videos
        feh # images
      ];
    };
  };
}
