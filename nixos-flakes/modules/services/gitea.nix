{ config, ... }:
{
  services.nginx.virtualHosts."git.my-domain.tld" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:3001/";
    };
  };

  services.postgresql = {
    ensureDatabases = [ config.services.gitea.user ];
    ensureUsers = [
      {
        name = config.services.gitea.database.user;
        ensurePermissions."DATABASE ${config.services.gitea.database.name}" = "ALL PRIVILEGES";
      }
    ];
  };

  sops.secrets."postgres/gitea_dbpass" = {
    sopsFile = ../.secrets/postgres.yaml; # bring your own password file
    owner = config.services.gitea.user;
  };

  services.gitea = {
    enable = true;
    appName = "My awesome Gitea server"; # Give the site a name
    database = {
      type = "postgres";
      password = "halohalo";
      # passwordFile = config.sops.secrets."postgres/gitea_dbpass".path;
    };
    domain = "git.my-domain.tld";
    rootUrl = "https://git.my-domain.tld/";
    httpPort = 3001;
  };
}
