{
  pkgs,
  lib,
  config,
  hostname,
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
      type = lib.types.str;
      description = "ssh key file";
      default = null;
    };
  };

  config = lib.mkIf config.keychain.enable {
    programs.keychain = {
      enable = true;
      keys = [
        config.keychain.keys
        # "/users/henri.vandersleyen/.ssh/knak"
      ];
    };
  };
}
