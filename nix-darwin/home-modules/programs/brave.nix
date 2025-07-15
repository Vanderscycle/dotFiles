{
  pkgs,
  inputs,
  system ? builtins.currentSystem,
  username,
  lib,
  config,
  ...
}:
{
  options = {
    brave.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables chromium based brave browser";
      default = false;
    };
  };

  config = lib.mkIf config.brave.enable {
    home.packages = with pkgs; [
      brave
    ];
  };
}
