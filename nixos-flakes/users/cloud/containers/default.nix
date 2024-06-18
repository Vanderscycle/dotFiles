{ username, ... }:
{
  imports = [
    ./portainer.nix
    ./transmission.nix
    ./home-automation.nix
  ];
  virtualisation = {
    oci-containers = {
      backend = "docker";
    };
  };
}
