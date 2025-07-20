{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    program.devops.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables devops programs";
      default = false;
    };
  };

  config = lib.mkIf config.program.devops.enable {
    home.packages = with pkgs; [
      # crypt
      openssl
      pwgen
      parted
      # sql/db
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
