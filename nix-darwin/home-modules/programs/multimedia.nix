{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    multimedia.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables multimedia";
      default = true;
    };
  };

  config = lib.mkIf config.multimedia.enable {
    home = {
      packages = with pkgs; [
        ytfzf
        vlc # videos
        feh # images
      ];
    };
  };
}
