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

    program.keychain.enableZshIntegration = lib.mkOption {
      type = lib.types.bool;
      description = "integrates w/ zsh";
      default = false;
    };

    program.keychain.enableFishIntegration = lib.mkOption {
      type = lib.types.bool;
      description = "integrates w/ fish";
      default = false;
    };

    program.keychain.keys = lib.mkOption {
      type = with lib.types; listOf str;
      description = "ssh key file";
      default = null;
    };
  };

  config = lib.mkIf config.program.keychain.enable {
    programs.keychain = {
      enable = true;
      enableFishIntegration = config.program.keychain.enableFishIntegration;
      enableZshIntegration = config.program.keychain.enableZshIntegration;
      keys = config.program.keychain.keys;
    };
  };
}
