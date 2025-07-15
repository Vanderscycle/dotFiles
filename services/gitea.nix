{ config, lib, ... }:
{
  options = {
    service.gitea.enable = lib.mkOption {
      type = lib.types.bool;
      description = "self hosted gh repo";
      default = false;
    };
  };

  config = lib.mkIf config.service.gitea.enable {
    services.gitea = {
      enable = true;
      settings = {
        # server.ROOT_URL = "http://0.0.0.0/gitea/";
        server.HTTP_PORT = 3001;
        metrics = {
          ENABLED = true;
        };
      };
    };

    # TODO: make a dynamic router provisionement like ssh.nix
    # services.gitea-actions-runner.instances = {
    #   "bob" = {
    #     enable = true;
    #     name = "bob";
    #     tokenFile = config.sops.secrets."gitea/runner/token".path;
    #     url = "gitea.homecloud.lan";
    #     labels = [
    #       "alpine-latest:docker://node:22-alpine"
    #     ];
    #   };
    # };
    # TODO: make another option for prometheus monitoring
    services.prometheus = {
      scrapeConfigs = [
        {
          job_name = "gitea";
          static_configs = [
            {
              targets = [ "gitea.homecloud.lan" ];
            }
          ];
        }
      ];
    };
  };
}
