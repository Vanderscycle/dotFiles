{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    cowsay.enable = lib.mkEnableOption "enables cowsay";
  };

  config = lib.mkIf config.cowsay.enable {
    home.packages = with pkgs; [
      neo-cowsay
    ];
  };
}
