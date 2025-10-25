{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    program.loveGameEngine.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables love game engine (lua2d)";
      default = false;
    };
  };
  config = lib.mkIf config.program.godot.enable {

    home.packages = with pkgs; [
      love
    ];
  };
}
