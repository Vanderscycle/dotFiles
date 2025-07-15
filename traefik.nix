{ meta, ... }:
{
  services.traefik = {
    # enable = false;
    enable = true;
    staticConfigOptions = {
      tls.certificates = [
        {
          certFile = "${builtins.path { path = ./cert-key.pem; }}";
          keyFile = "${builtins.path { path = ./fullchain.pem; }}";
        }
      ];
      api = {
        dashboard = true; # ip:8080
        insecure = true;
      };
      log = {
        level = "DEBUG";
        format = "json";
      };
      entryPoints = {
        web = {
          address = ":80";
          # http.redirections.entryPoint = {
          #   to = "websecure";
          #   scheme = "https";
          # };
        };
        websecure = {
          address = ":443";
        };
        traefik = {
          address = ":8080";
        };
      };
    };

    dynamicConfigOptions = {
      http = {
        routers = {
          n8n-router = {
            rule = "Host(`n8n.homecloud.lan`)";
            service = "n8n-service";
            entryPoints = [
              "web"
              "websecure"
            ];
            # tls = { }; # enables TLS without certResolver
          };

          gitea-router = {
            rule = "Host(`gitea.homecloud.lan`)";
            service = "gitea-service";
            entryPoints = [ "web" ];
          };

          home-assistant-router = {
            rule = "Host(`/ha.homecloud.lan`)";
            service = "home-assistant-service";
            entryPoints = [ "web" ];
          };

          nextcloud-router = {
            # rule = "PathPrefix(`/nextcloud`)";
            rule = "Host(`nextcloud.homecloud.lan`)";
            service = "nextcloud-service";
            entryPoints = [ "web" ];
            middlewares = [ "strip-nextcloud-prefix" ];
          };

          jellyfin-router = {
            rule = "Host(`jellyfin.homecloud.lan`)";
            service = "jellyfin-service";
            entryPoints = [ "web" ];
          };

          paperless-router = {
            rule = "Host(`paperless.homecloud.lan`)";
            service = "paperless-service";
            entryPoints = [ "web" ];
          };

          transmission-router = {
            rule = "Host(`transmission.homecloud.lan`)";
            service = "transmission-service";
            entryPoints = [ "web" ];
            # middlewares = [ "strip-transmission-prefix" ];
          };

          kavita-router = {
            rule = "Host(`read.homecloud.lan`)";
            service = "kavita-service";
            entryPoints = [ "web" ];
          };

          sonarr-router = {
            rule = "Host(`sonarr.homecloud.lan`)";
            service = "sonarr-service";
            entryPoints = [ "web" ];
          };

          radarr-router = {
            rule = "Host(`radarr.homecloud.lan`)";
            service = "radarr-service";
            entryPoints = [ "web" ];
          };

          homarr-router = {
            rule = "Host(`homarr.homecloud.lan`)";
            service = "homarr-service";
            entryPoints = [ "web" ];
          };

          bazarr-router = {
            rule = "Host(`bazarr.homecloud.lan`)";
            service = "bazarr-service";
            entryPoints = [ "web" ];
          };

          prowlarr-router = {
            rule = "Host(`prowlarr.homecloud.lan`)";
            service = "prowlarr-service";
            entryPoints = [ "web" ];
          };

          lidarr-router = {
            rule = "Host(`lidarr.homecloud.lan`)";
            service = "lidarr-service";
            entryPoints = [ "web" ];
          };

          readarr-router = {
            rule = "Host(`readarr.homecloud.lan`)";
            service = "readarr-service";
            entryPoints = [ "web" ];
          };

          immich-router = {
            rule = "Host(`immich.homecloud.lan`)";
            service = "immich-service";
            entryPoints = [ "web" ];
          };

          grafana-router = {
            rule = "Host(`grafana.homecloud.lan`)";
            service = "grafana-service";
            entryPoints = [ "web" ];
          };

          prometheus-router = {
            rule = "Host(`prometheus.homecloud.lan`)";
            service = "prometheus-service";
            entryPoints = [ "web" ];
          };

          uptime-kuma-router = {
            rule = "Host(`uptime-kuma.homecloud.lan`)";
            service = "uptime-kuma-service";
            entryPoints = [ "web" ];
          };
        };

        services = {
          n8n-service = {
            loadBalancer.servers = [
              { url = "http://0.0.0.0:5678"; }
            ];
          };

          gitea-service = {
            loadBalancer.servers = [
              { url = "http://0.0.0.0:3001"; }
            ];
          };

          home-assistant-service = {
            loadBalancer.servers = [
              { url = "http://0.0.0.0:8123"; }
            ];
          };

          nextcloud-service = {
            loadBalancer.servers = [
              { url = "http://0.0.0.0:9999"; }
            ];
          };

          jellyfin-service = {
            loadBalancer.servers = [
              { url = "http://0.0.0.0:8096"; }
            ];
          };
          paperless-service = {
            loadBalancer.servers = [
              { url = "http://0.0.0.0:28981"; }
            ];
          };

          kavita-service = {
            loadBalancer.servers = [
              { url = "http://0.0.0.0:5000"; }
            ];
          };
          sonarr-service = {
            loadBalancer.servers = [
              { url = "http://0.0.0.0:8989"; }
            ];
          };
          radarr-service = {
            loadBalancer.servers = [
              { url = "http://0.0.0.0:7878"; }
            ];
          };
          transmission-service = {
            loadBalancer.servers = [
              { url = "http://0.0.0.0:9091"; }
            ];
          };

          homarr-service = {
            loadBalancer.servers = [
              { url = "http://0.0.0.0:7575"; }
            ];
          };

          bazarr-service = {
            loadBalancer.servers = [
              { url = "http://0.0.0.0:6767"; }
            ];
          };

          prowlarr-service = {
            loadBalancer.servers = [
              { url = "http://0.0.0.0:9696"; }
            ];
          };

          lidarr-service = {
            loadBalancer.servers = [
              { url = "http://0.0.0.0:8686"; }
            ];
          };

          readarr-service = {
            loadBalancer.servers = [
              { url = "http://0.0.0.0:8787"; }
            ];
          };
          immich-service = {
            loadBalancer.servers = [
              { url = "http://0.0.0.0:2283"; }
            ];
          };

          grafana-service = {
            loadBalancer.servers = [
              { url = "http://0.0.0.0:4010"; }
            ];
          };

          prometheus-service = {
            loadBalancer.servers = [
              { url = "http://0.0.0.0:4011"; }
            ];
          };

          uptime-kuma-service = {
            loadBalancer.servers = [
              { url = "http://0.0.0.0:4100"; }
            ];
          };
        };

        middlewares = {

          strip-nextcloud-prefix = {
            stripPrefix.prefixes = [ "/nextcloud" ];
          };

          strip-transmission-prefix = {
            stripPrefix.prefixes = [ "/transmission" ];
          };
        };
      };
    };
  };
}
