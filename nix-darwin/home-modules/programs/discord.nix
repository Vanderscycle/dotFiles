{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    program.discord.enable = lib.mkOption {
      type = lib.types.bool;
      description = "enables discord";
      default = false;
    };
  };
  config = lib.mkIf config.program.discord.enable {
    nixpkgs.config.allowUnfree = true;
    home = {
      packages = with pkgs; [ discord ];
    };
  };
}
