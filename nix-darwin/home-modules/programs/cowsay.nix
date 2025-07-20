{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    program.cowsay.enable = lib.mkOption {
      type = lib.types.bool;
      description = "moo moo";
      default = false;
    };
  };

  config = lib.mkIf config.program.cowsay.enable {
    home.packages = with pkgs; [
      neo-cowsay
    ];
  };
}
