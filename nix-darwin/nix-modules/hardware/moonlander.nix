{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    moonlander.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables moonlander wally program";
      default = true;
    };
  };
  config = lib.mkIf config.moonlander.enable {
    environment.systemPackages = with pkgs; [
      wally-cli
      keymapp
    ];
  };
}
