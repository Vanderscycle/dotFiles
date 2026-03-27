{
  pkgs,
  lib,
  config,
  meta,
  ...
}:
{
  options = {
    container.docker.enable = lib.mkOption {
      type = lib.types.bool;
      description = "enables docker";
      default = true;
    };
  };

  config = lib.mkIf config.container.docker.enable {

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
