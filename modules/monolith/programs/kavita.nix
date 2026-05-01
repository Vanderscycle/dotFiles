{ ... }:
{
  stars.program._.uptime-kuma = {
    nixos =
      { config, ... }:
      {
        services.kavita = {
          enable = true;
          # tokenKeyFile = config.sops.secrets."kavita/token".path;
          settings = {
            Port = 5001;
          };
        };
      };
    homeManager = {
    };
  };
}
