{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    program.opencode.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables comfier nix experience";
      default = false;
    };
  };

  config = lib.mkIf config.program.opencode.enable {
    home = {
      packages = with pkgs; [
        opencode
      ];
    };
  };
}
