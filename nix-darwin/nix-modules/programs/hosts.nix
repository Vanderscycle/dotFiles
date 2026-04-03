{
  lib,
  config,
  hosts,
  ...
}:
{

  imports = [
    hosts.nixosModule
  ];
  options = {
    program.networking.stevenblack.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables StevenBlack hosts-based ad-blocking";
      default = false;
    };
  };

  config = lib.mkIf config.program.networking.enable {
    networking = {
      stevenBlackHosts = lib.mkIf config.program.networking.stevenblack.enable {
        enable = true;
        blockFakenews = true;
        blockGambling = true;
      };
    };
  };
}
