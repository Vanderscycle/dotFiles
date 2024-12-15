{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    docker.enable = lib.mkOption {
      type = lib.types.bool;
      description = "enables docker";
      default = false;
    };
  };

  config = lib.mkIf config.docker.enable {
    environment.systemPackages = with pkgs; [
      docker
    ];

    virtualisation = {
      docker = {
        enable = true;
        rootless = {
          setSocketVariable = true;
          enable = true;
        };
      };
    };
  };
}
