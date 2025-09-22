{
  lib,
  config,
  ...
}:
{
  options = {
    program.keychain.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables keychain";
      default = false;
    };

    program.keychain.keys = lib.mkOption {
      type = with lib.types; listOf str;
      description = "ssh key file";
      default = null;
    };
  };

  config = lib.mkIf config.program.keychain.enable {
    # TODO: Deperecated (update)
    programs.keychain = {
      enable = true;
      keys = config.program.keychain.keys;
    };
  };
}
