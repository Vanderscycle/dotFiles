{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    program.godot.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables godot";
      default = true;
    };
  };
  config = lib.mkIf config.program.godot.enable {
    environment.systemPackages = [
      pkgs.godot
    ];
  };
}
