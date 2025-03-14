{
  pkgs,
  system ? builtins.currentSystem,
  lib,
  config,
  ...
}:
let
  # Get the current system architecture
  currentSystem = system;

  packagesForSystem =
    lib.mkIf (currentSystem == "x86_64-linux") {
      # packages specific to x86_64-linux
      packages = with pkgs; [
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
    }
    // lib.mkIf (currentSystem == "aarch64-linux") {
      # packages specific to aarch64-linux
      packages = with pkgs; [
        # backend api calls
        # dns
        dogdns
      ];
    };
in
{
  options = {
    devops.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables devops programs";
      default = true;
    };
  };

  config = lib.mkIf config.devops.enable {
    # Only apply packagesForSystem if devops is enabled
    home = packagesForSystem;
  };
}
