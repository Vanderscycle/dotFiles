{
  lib,
  config,
  hosts,
  ...
}:

{
  # 1. Only include the external module in the 'imports' list if enabled
  imports = lib.optional config.program.networking.stevenblack.enable hosts.nixosModule;

  options = {
    program.networking.stevenblack.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables StevenBlack hosts-based ad-blocking";
      default = false;
    };
  };

  # 2. Use mkIf to apply the configuration
  config = lib.mkIf config.program.networking.stevenblack.enable {
    networking.stevenBlackHosts = {
      enable = true;
      blockFakenews = true;
      blockGambling = true;
    };
  };
}
