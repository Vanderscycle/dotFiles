{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    program.beekeeper.enable = lib.mkOption {
      type = lib.types.bool;
      description = "enables the best db inspector";
      default = false;
    };
  };
  config = lib.mkIf config.program.beekeeper.enable {
    nixpkgs.config.permittedInsecurePackages = [
      "beekeeper-studio-5.3.4"
    ];
    home = {
      packages = with pkgs; [ beekeeper-studio ];
    };
  };
}
