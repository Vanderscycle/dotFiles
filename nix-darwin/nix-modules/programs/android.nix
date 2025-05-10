{
  pkgs,
  lib,
  username,
  config,
  ...
}:
{
  options = {
    android.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables android software (adb)";
      default = false;
    };
  };

  config = lib.mkIf config.android.enable {
    programs.adb.enable = true;
    users.users.${username}.extraGroups = [ "adbusers" ];
  };
}
