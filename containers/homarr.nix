{
  meta,
  config,
  lib,
  ...
}:
{
  options = {
    container.homarr.enable = lib.mkOption {
      type = lib.types.bool;
      description = "homepage service";
      default = false;
    };
  };

  config = lib.mkIf config.container.homarr.enable {
    virtualisation.oci-containers = {
      containers = {
        # https://search.nixos.org/options?channel=24.11&from=0&size=50&sort=relevance&type=packages&query=oci-containers.containers
        homarr = {
          image = "ghcr.io/homarr-labs/homarr:latest";
          ports = [ "7575:7575" ];
          # extraOptions = [ "--network=host" ]; # TODO: check for traefik
          environment = {
            SECRET_ENCRYPTION_KEY = builtins.readFile config.sops.secrets."docker/homarr/enc_key".path;
          };
          volumes = [
            "/var/run/docker.sock:/var/run/docker.sock"
            "/home/${meta.username}/docker/homarr:/appdata"
          ];
        };
      };
    };
  };
}
