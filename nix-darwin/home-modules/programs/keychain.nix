{
  lib,
  config,
  ...
}:
{
  options = {
    keychain.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables keychain";
      default = false;
    };

    keychain.keys = lib.mkOption {
      type = with lib.types; listOf str;
      description = "ssh key file";
      default = null;
    };
  };

  config = lib.mkIf config.keychain.enable {
    programs.keychain = {
      enable = true;
      keys = config.keychain.keys;
    };
  };
}
