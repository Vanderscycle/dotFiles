{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    nh.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables comfier nix experience";
      default = true;
    };
    nh.flakeLocation = lib.mkOption {
      type = lib.types.str;
      description = "where the config flake is";
      default = null;
    };
  };

  config = lib.mkIf config.nh.enable {
    home = {
      packages = with pkgs; [
        nh
        nvd
        nix-output-monitor
        nixos-anywhere
      ];
      sessionVariables = {
        NH_FLAKE = config.nh.flakeLocation;
      };
    };
  };
}
