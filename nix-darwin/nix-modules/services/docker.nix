{
  pkgs,
  lib,
  config,
  meta,
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

    users.users.${meta.username} = {
      extraGroups = [
        "docker"
      ];
    };
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
