{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    cowsay.enable = lib.mkOption {
      type = lib.types.bool;
      description = "moo moo";
      default = false;
    };
  };

  config = lib.mkIf config.cowsay.enable {
    home.packages = with pkgs; [
      neo-cowsay
    ];
  };
}
