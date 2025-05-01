{
  pkgs,
  system ? builtins.currentSystem,
  lib,
  config,
  ...
}:
let
  # Get the current system architecture
  packagesForSystem = lib.mkIf (system == "aarch64-linux") {
    packages = with pkgs; [
      dogdns
    ];
  };
in
{
  options = {
    devops.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables devops programs";
      default = false;
    };
  };

  config = lib.mkIf config.devops.enable {
    home.packages = with pkgs; [
      # crypt
      openssl
      pwgen
      # sql/db
      beekeeper-studio # not supported on aarch64-darwin
      # mysql-workbench # not supported on aarch64-darwin
      # backend api calls
      insomnia # not supported on aarch64-darwin
      # dns
      dogdns
      dive
      lsof
    ];
  };
}
