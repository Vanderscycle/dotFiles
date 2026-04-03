{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    program.spotify.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables paid music";
      default = false;
    };
  };

  config = lib.mkIf config.program.spotify.enable {
    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "spotify"
      ];
    home.packages = with pkgs; [
      spotify
    ];
  };
}
